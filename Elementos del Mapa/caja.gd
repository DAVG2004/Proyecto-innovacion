extends RigidBody2D

@export var deceleration: float = 250.0  # Frenado más rápido

func _ready():
	add_to_group("pushable")  # Añadir al grupo de objetos empujables

func apply_push(force: float):
	apply_central_force(Vector2(force, 0))

func _physics_process(_delta):
	# Frenar gradualmente cuando no se empuja
	if abs(linear_velocity.x) > 1.0:
		var brake_force = -sign(linear_velocity.x) * deceleration
		apply_central_force(Vector2(brake_force, 0))
	else:
		linear_velocity.x = 0.0
