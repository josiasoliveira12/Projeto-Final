
extends CharacterBody2D

@export var speed: float = 120.0

@onready var sprite: AnimatedSprite2D = $animacao

var ultima_direcao: String = "sul"


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
		ultima_direcao = animacao_andar.replace("andar_", "")

		if sprite.animation != animacao_andar:
			sprite.play(animacao_andar)

	else:
		# Sem movimento: mantém a última direção
		var animacao_parado = "parado_" + ultima_direcao

		if sprite.animation != animacao_parado:
			sprite.play(animacao_parado)

	move_and_slide()
