class_name plataforma2
extends StaticBody2D

@export var target_node: Node  # Asigna el nodo desde el inspector
@export var visible_time: float = 3.0
@export var hidden_time: float = 2.0

@onready var timer = $Timer
@onready var collision_shape: CollisionShape2D = null

func _ready():
	# Si no se asignó un nodo específico, usa el padre
	if not target_node:
		target_node = get_parent()
	
	# Buscar CollisionShape2D en el nodo objetivo
	collision_shape = find_collision_shape_in_children(target_node)
	
	if collision_shape == null:
		push_warning("No se encontró CollisionShape2D en el nodo objetivo")
	
	# Configurar el timer
	setup_timer(visible_time)
	timer.timeout.connect(handle_timer_timeout)
	target_node.visible = true
	update_collision_state(false)  # Asegurar que la colisión está activa al inicio

func find_collision_shape_in_children(node: Node) -> CollisionShape2D:
	# Busca recursivamente un CollisionShape2D
	if node is CollisionShape2D:
		return node
	for child in node.get_children():
		var result = find_collision_shape_in_children(child)
		if result:
			return result
	return null

func setup_timer(duration: float):
	timer.wait_time = duration
	timer.start()

func update_collision_state(disabled: bool):
	if collision_shape != null:
		collision_shape.disabled = disabled

func handle_timer_timeout():
	if target_node.visible:
		# Ocultar el nodo y desactivar colisión
		target_node.visible = false
		update_collision_state(true)
		setup_timer(hidden_time)
	else:
		# Mostrar el nodo y activar colisión
		target_node.visible = true
		update_collision_state(false)
		setup_timer(visible_time)
