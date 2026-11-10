
extends CharacterBody2D

@export var speed: float = 120.0

@onready var sprite: AnimatedSprite2D = $animacao

var ultima_direcao: String = "sul"

# Controle da distância percorrida
var distancia_percorrida: float = 0.0
var tamanho_passo: float = 32.0


var vidas: int = 3
var pode_receber_dano: bool = true

func _physics_process(_delta):
	var direction = Vector2.ZERO
	var animacao_andar = ""

	# Movimentação nas oito direções
	if Input.is_action_pressed("mover_norte"):
		direction = Vector2(0, -1)
		animacao_andar = "norte"

	elif Input.is_action_pressed("mover_sul"):
		direction = Vector2(0, 1)
		animacao_andar = "sul"

	elif Input.is_action_pressed("mover_leste"):
		direction = Vector2(1, 0)
		animacao_andar = "leste"

	elif Input.is_action_pressed("mover_oeste"):
		direction = Vector2(-1, 0)
		animacao_andar = "oeste"

	elif Input.is_action_pressed("mover_nordeste"):
		direction = Vector2(1, -1)
		animacao_andar = "nordeste"

	elif Input.is_action_pressed("mover_noroeste"):
		direction = Vector2(-1, -1)
		animacao_andar = "noroeste"

	elif Input.is_action_pressed("mover_sudeste"):
		direction = Vector2(1, 1)
		animacao_andar = "sudeste"

	elif Input.is_action_pressed("mover_sudoeste"):
		direction = Vector2(-1, 1)
		animacao_andar = "sudoeste"

	# Normaliza a direção para manter a mesma velocidade
	# nas movimentações diagonais
	direction = direction.normalized()

	# Define a velocidade do personagem
	velocity = direction * speed

	# Executa a animação correspondente
	if animacao_andar != "":
		ultima_direcao = animacao_andar

		if sprite.animation != animacao_andar:
			sprite.play(animacao_andar)

	else:
		# Sem movimento: mantém a última direção
		var animacao_parado = "parado_" + ultima_direcao

		if sprite.animation != animacao_parado:
			sprite.play(animacao_parado)

	# Guarda a posição antes do movimento
	var posicao_anterior = global_position

	move_and_slide()

	# Calcula a distância realmente percorrida
	var distancia_movida = posicao_anterior.distance_to(global_position)

	distancia_percorrida += distancia_movida


func receber_dano():
	if not is_inside_tree() or not pode_receber_dano:
		return

	pode_receber_dano = false
	vidas -= 1

	# Atualiza a pontuação
	get_node("../GerenciadorPistas").atualizar_pontuacao(-100)

	# Atualiza as vidas
	var texto_vida = get_node_or_null("../Interface/TextoVida")

	if texto_vida != null:
		texto_vida.text = "Vida: " + str(vidas)

	# Verifica Game Over
	if vidas <= 0:
		var arvore = get_tree()

		if arvore != null:
			arvore.call_deferred("change_scene_to_file", "res://tela_derrota.tscn")

		return

	# Aguarda antes de permitir outro dano
	await get_tree().create_timer(1.5).timeout

	if is_inside_tree():
		pode_receber_dano = true
		
	

# Retorna a quantidade de passos completos percorridos
func obter_passos_percorridos() -> int:
	return int(distancia_percorrida / tamanho_passo)
