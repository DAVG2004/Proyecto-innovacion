extends Area2D


func _on_body_entered(body: Node2D) -> void:
	ControladorEstadistico.moneda_recogida()
	queue_free()
	pass # Replace with function body.
