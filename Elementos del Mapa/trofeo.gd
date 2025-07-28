extends Area2D

signal sprite_activado

var counter: int = 0
@onready var my_sprite: Sprite2D = $Sprite2D

func _ready():
	if my_sprite:
		my_sprite.visible = false
	else:
		push_error("No se encontró el Sprite2D. Verifica la ruta.")

func increment_counter():
	counter += 1
	print("Contador actual: ", counter)
	
	if counter >= 7 && my_sprite:
		my_sprite.visible = true
		print("¡Sprite activado!")
		if counter == 7:
			sprite_activado.emit()


func _on_body_entered(body: Node2D) -> void:
	var escena = get_tree().current_scene
	var id_nivel = escena.get("id_nivel")

	print("✅ Nivel detectado con ID:", id_nivel)

	match id_nivel:
		1:
			ControladorEstadistico.completar_nivel1()
		2:
			ControladorEstadistico.completar_nivel2()
		_:
			print("⚠️ ID de nivel desconocido:", id_nivel)

	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Menus/resultados.tscn")
