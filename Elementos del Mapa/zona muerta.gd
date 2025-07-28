extends Area2D



func _ready():
	# Conecta la señal body_entered (o area_entered según tu caso)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	ControladorEstadistico.caida_detectada()
	# Verifica que el cuerpo que entró es el jugador
	if body.is_in_group("personaje") or body.name == "personaje":  # Ajusta según tu estructura
		reset_player(body)


func reset_player(player):
	# Opción 1: Restablecer posición (si solo necesitas moverlo)
	player.global_position = Vector2(-471, 37)  # Posición inicial
