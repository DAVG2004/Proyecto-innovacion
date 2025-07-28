extends Node2D

@export var id_nivel: int = 2
# Cuando el jugador recoja una moneda (en el script del nivel 2)
func _on_moneda_recogida():
	$ControlGlobal.moneda_recogida_nivel2()

# Cuando el jugador se caiga (en el script del nivel 2)
func _on_jugador_caida():
	$ControlGlobal.caida_detectada_nivel2()

# Cuando se complete el nivel (en el script del nivel 2)
func _on_meta_alcanzada():
	$ControlGlobal.completar_nivel2()
