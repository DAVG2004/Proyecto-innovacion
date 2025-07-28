extends Area2D

# Configura la posición de destino en el inspector
@export var target_position: Vector2 = Vector2(-471, 37)

func _ready():
	# Conectar la señal de cuerpo entrado
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Teletransporta cualquier cuerpo físico que entre
	if body is PhysicsBody2D:  # Esto incluye CharacterBody2D, RigidBody2D y StaticBody2D
		body.global_position = target_position
		
		# Opcional: Resetear velocidad si es un cuerpo dinámico
		if body is CharacterBody2D:
			body.velocity = Vector2.ZERO
		elif body is RigidBody2D:
			body.linear_velocity = Vector2.ZERO
