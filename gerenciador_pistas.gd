
extends Node

# Referências aos elementos da cena
@onready var pontos_das_pistas = $"../PontosDasPistas"
@onready var jogador = $"../player"
@onready var texto_instrucao: Label = $"../Interface/PainelInstrucao/TextoInstrucao"

# Configurações das pistas
const TOTAL_PISTAS = 5
const RAIO_PROXIMIDADE = 32.0

# Limites da área de sorteio
const X_MIN = 250
const X_MAX = 1800
const Y_MIN = 250
const Y_MAX = 1250

# Configurações do sorteio
const DISTANCIA_MINIMA = 250.0
const DISTANCIA_MINIMA_JOGADOR = 300.0
const MAX_TENTATIVAS = 500

# Armazena as posições sorteadas
var objetivos: Array[Vector2] = []

# Referências aos marcadores
var pontos_objetivos: Array = []

# Controla a pista atual
var pista_atual: int = 0

# Controla se o sorteio foi concluído
var sorteio_concluido: bool = false


func _ready():
	randomize()

	# Aguarda a primeira atualização da física
	await get_tree().physics_frame

	sortear_objetivos()


# Sorteia as posições das cinco pistas e do tesouro
func sortear_objetivos():
	objetivos.clear()
	pista_atual = 0
	sorteio_concluido = false

	# Referências aos seis marcadores
	pontos_objetivos = [
		pontos_das_pistas.get_node("pista1"),
		pontos_das_pistas.get_node("pista2"),
		pontos_das_pistas.get_node("pista3"),
		pontos_das_pistas.get_node("pista4"),
		pontos_das_pistas.get_node("pista5"),
		pontos_das_pistas.get_node("Tesouro")
	]

	for i in range(TOTAL_PISTAS + 1):
		var posicao_valida = false
		var nova_posicao = Vector2.ZERO
		var tentativas = 0

		while not posicao_valida and tentativas < MAX_TENTATIVAS:
			tentativas += 1

			# Sorteia uma posição
			nova_posicao = Vector2(
				randf_range(X_MIN, X_MAX),
				randf_range(Y_MIN, Y_MAX)
			)

			posicao_valida = true

			# Verifica a distância dos outros objetivos
			for posicao in objetivos:
				if nova_posicao.distance_to(posicao) < DISTANCIA_MINIMA:
					posicao_valida = false
					break

			# Verifica se existe algum obstáculo
			if posicao_valida:
				if posicao_tem_obstaculo(nova_posicao):
					posicao_valida = false

			# Impede objetivos próximos da posição inicial
			if posicao_valida:
				if nova_posicao.distance_to(jogador.global_position) < DISTANCIA_MINIMA_JOGADOR:
					posicao_valida = false

		# Verifica se encontrou uma posição válida
		if not posicao_valida:
			push_error(
				"Não foi possível encontrar uma posição válida para o objetivo "
				+ str(i + 1)
			)
			return

		# Guarda e posiciona o objetivo
		objetivos.append(nova_posicao)
		pontos_objetivos[i].global_position = nova_posicao

		# Mantém o objetivo invisível
		pontos_objetivos[i].visible = false

	sorteio_concluido = true

	print("Objetivos sorteados:")
	print(objetivos)

	# Mostra a primeira instrução
	atualizar_instrucao()


# Verifica se existe colisão na posição escolhida
func posicao_tem_obstaculo(posicao: Vector2) -> bool:
	var espaco = get_viewport().world_2d.direct_space_state

	var consulta = PhysicsPointQueryParameters2D.new()
	consulta.position = posicao
	consulta.collision_mask = 1
	consulta.collide_with_areas = true
	consulta.collide_with_bodies = true

	var resultados = espaco.intersect_point(consulta)

	return not resultados.is_empty()


# Cria um indicador visual para cada objetivo
func criar_indicador(ponto: Node2D, indice: int):
	var indicador = Label.new()

	if indice < TOTAL_PISTAS:
		indicador.text = "PISTA " + str(indice + 1)
		indicador.add_theme_color_override(
			"font_color", Color.CYAN
		)
	else:
		indicador.text = "TESOURO"
		indicador.add_theme_color_override(
			"font_color", Color.GOLD
		)

	indicador.add_theme_font_size_override("font_size", 18)

	indicador.add_theme_color_override(
		"font_outline_color", Color.BLACK
	)

	indicador.add_theme_constant_override(
		"outline_size", 5
	)

	indicador.size = Vector2(100, 25)
	indicador.position = Vector2(-50, -40)
	indicador.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	ponto.add_child(indicador)


# Verifica se o personagem chegou perto do objetivo atual
func _physics_process(_delta):
	if not sorteio_concluido:
		return

	# Atualiza a direção e a distância no painel
	atualizar_instrucao()

	# Verifica se todos os objetivos foram encontrados
	if pista_atual >= TOTAL_PISTAS + 1:
		return

	var ponto_atual = pontos_objetivos[pista_atual]

	var distancia = jogador.global_position.distance_to(
		ponto_atual.global_position
	)

	if distancia <= RAIO_PROXIMIDADE:
		encontrar_objetivo()


# Avança para o próximo objetivo
func encontrar_objetivo():
	if pista_atual < TOTAL_PISTAS:
		print("Pista ", pista_atual + 1, " encontrada!")
	else:
		print("TESOURO ENCONTRADO! Você venceu!")

	pista_atual += 1

	# Atualiza imediatamente a instrução
	atualizar_instrucao()


# Calcula a direção do jogador até o próximo objetivo
func obter_direcao(alvo: Vector2) -> String:
	var diferenca = alvo - jogador.global_position

	if abs(diferenca.x) > abs(diferenca.y) * 2:
		return "Leste" if diferenca.x > 0 else "Oeste"

	if abs(diferenca.y) > abs(diferenca.x) * 2:
		return "Sul" if diferenca.y > 0 else "Norte"

	if diferenca.x > 0 and diferenca.y < 0:
		return "Nordeste"
	elif diferenca.x < 0 and diferenca.y < 0:
		return "Noroeste"
	elif diferenca.x > 0 and diferenca.y > 0:
		return "Sudeste"
	else:
		return "Sudoeste"


# Atualiza o painel com a instrução atual
func atualizar_instrucao():
	if pista_atual >= TOTAL_PISTAS + 1:
		texto_instrucao.text = "TESOURO ENCONTRADO!\nVocê venceu!"
		return

	var ponto_atual = pontos_objetivos[pista_atual]

	var distancia = jogador.global_position.distance_to(
		ponto_atual.global_position
	)

	var passos = ceili(distancia / 32.0)
	var direcao = obter_direcao(ponto_atual.global_position)

	var mensagens = [
		"Encontre a primeira pista!",
		"Encontre a segunda pista!",
		"Encontre a terceira pista!",
		"Encontre a quarta pista!",
		"Encontre a quinta pista!"
	]

	if pista_atual < TOTAL_PISTAS:
		texto_instrucao.text = mensagens[pista_atual] + "\n\n" + \
			"Distância: %d passos para %s." % [
				passos,
				direcao
			]
	else:
		texto_instrucao.text = "Você encontrou as cinco pistas!\n\n" + \
			"O tesouro está a %d passos para %s." % [
				passos,
				direcao
			]
