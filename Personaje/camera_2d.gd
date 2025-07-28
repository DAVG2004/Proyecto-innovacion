extends Camera2D

@export var object_to_follow: Node2D
@export var max_y_position := 360.0  # Límite superior (no mostrará nada por encima de Y=360)

func _process(delta):
	var target_position = object_to_follow.position
	
	# La cámara seguirá al personaje, pero nunca mostrará por encima de Y=360
	position = Vector2(
		target_position.x,
		min(target_position.y, max_y_position)  # Usamos min() para asegurar que nunca supere max_y_position
	)
