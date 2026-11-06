
extends CharacterBody2D

@export var velocidade: float = 60.0

@onready var sprite: AnimatedSprite2D = $animacao

var direcao: Vector2 = Vector2.RIGHT

var direcoes = [
	Vector2.RIGHT,
	Vector2.LEFT,
	Vector2.UP,
	Vector2.DOWN
]


func _ready():
	randomize()
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	escolher_direcao()


func _physics_process(_delta):
	velocity = direcao * velocidade
	move_and_slide()

	# Verifica colisões com outros corpos
	for i in get_slide_collision_count():
		var colisao = get_slide_collision(i)
		var corpo = colisao.get_collider()

		if corpo.name == "player":
			corpo.receber_dano()

	if is_on_wall():
		escolher_direcao()

	atualizar_animacao()


func escolher_direcao():
	direcao = direcoes.pick_random()


func atualizar_animacao():
	if direcao == Vector2.UP:
		sprite.play("andar_sul")
		sprite.flip_v = false

	elif direcao == Vector2.DOWN:
		sprite.play("andar_norte")
		sprite.flip_v = false

	elif direcao == Vector2.RIGHT:
		sprite.play("andar_oeste")
		sprite.flip_v = true

	elif direcao == Vector2.LEFT:
		sprite.play("andar_leste")
		sprite.flip_v = true
