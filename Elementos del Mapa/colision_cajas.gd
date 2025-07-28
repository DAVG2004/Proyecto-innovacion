extends Area2D

@export var target_node: NodePath  # Esto aparecerá en el inspector
var target: Node = null

func _ready():
	body_entered.connect(_on_body_entered)
	# Convertir el NodePath en una referencia al nodo real
	if target_node:
		target = get_node(target_node)

func _on_body_entered(body: Node):
	# Verificar que no sea el área misma y que el target esté asignado
	if body != self and target != null and target.has_method("increment_counter"):
		target.increment_counter()
