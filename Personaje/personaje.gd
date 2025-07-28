class_name PersonajeMueve
extends CharacterBody2D

@export var JUMP = 150
@export var gravity = 150
@export var speed = 150
@export var push_force: float = 500.0  # Fuerza para empujar cajas

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var push_area = $PushArea  # Área para detectar cajas

var motion = Vector2()
var is_pushing: bool = false
var push_direction: int = 0
var current_box: RigidBody2D = null

func _ready():
	# Conectar señales del área de empuje
	push_area.body_entered.connect(_on_push_area_body_entered)
	push_area.body_exited.connect(_on_push_area_body_exited)

func _physics_process(delta):
	# Movimiento horizontal
	var direction = Input.get_axis("mover izquierda", "mover derecha")
	velocity.x = speed * direction
	
	# Animaciones
	if direction > 0:
		sprite.flip_h = false
		animation.play("Caminar")
		push_direction = 1
	elif direction < 0:
		sprite.flip_h = true
		animation.play("Caminar")
		push_direction = -1
	elif direction == 0:
		animation.play("Quieto")
	
	# Gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	
	# Saltar
	var jump_pressed = Input.is_action_just_pressed("jump") and is_on_floor()
	if jump_pressed:
		velocity.y = velocity.y - JUMP
	
	# Empujar caja si está tocando una
	if is_pushing and current_box != null and direction != 0:
		current_box.apply_push(push_direction * push_force)
	
	move_and_slide()

# Cuando una caja entra en el área de empuje
func _on_push_area_body_entered(body: Node):
	if body.is_in_group("pushable"):
		is_pushing = true
		current_box = body
		print("Caja detectada para empujar")

# Cuando una caja sale del área de empuje
func _on_push_area_body_exited(body: Node):
	if body == current_box:
		is_pushing = false
		current_box = null
		print("Dejó de empujar caja")
