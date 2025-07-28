extends Node2D


func _on_empezar_pressed() -> void:
	get_tree().change_scene_to_file("res://niveles/nivel 1.tscn")

func _on_instrucciones_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/instrucciones.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
