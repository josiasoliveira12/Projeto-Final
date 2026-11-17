extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextoPontuacaoFinal.text = "     Pontuação final: " + str(ResultadoJogo.pontuacao_final)
	$TextoVidaRestantes.text = "Vidas restantes: " + str(ResultadoJogo.vidas_finais)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_botao_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_inicial.tscn")
