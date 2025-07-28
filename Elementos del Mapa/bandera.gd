extends Area2D



func _on_body_entered(body: Node2D) -> void:
	ControladorEstadistico.completar_nivel1()
	get_tree().change_scene_to_file("res://niveles/nivel 2.tscn")
