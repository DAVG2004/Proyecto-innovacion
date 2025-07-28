class_name  personajeMueve3
extends CharacterBody2D

@export var JUMP = 150
@export var gravity = 150
@export var speed = 150

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

var motion = Vector2()


func _physics_process(delta):
	
	#movimiento horizontal
	var direction = Input.get_axis("mover izquierda", "mover derecha")
	velocity.x = speed * direction
	
	if Input.is_action_just_pressed("mover derecha"):
		sprite.flip_h = false 
		animation.play("Caminar")
		
	elif  Input.is_action_just_released("mover derecha"):
		animation.play("Quieto")
		
	if Input.is_action_just_pressed("mover izquierda"):
		sprite.flip_h = true
		animation.play("Caminar")
	elif  Input.is_action_just_released("mover izquierda"):
		animation.play("Quieto")
	
	#gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	
	#saltar
	var jump_pressed = Input.is_action_just_pressed("jump") and is_on_floor()
	if jump_pressed:
		velocity.y = velocity.y - JUMP
	
	move_and_slide()
