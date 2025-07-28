extends Node2D

# Señal para comunicación
signal nivel_completado(nivel: int)

# Estadísticas
var estadisticas = {
	"nivel1": {
		"monedas_recogidas": 0,
		"caidas": 0,
		"tiempo_inicio": 0.0,
		"tiempo_total": 0.0
	},
	"nivel2": {
		"monedas_recogidas": 0,
		"caidas": 0,
		"tiempo_inicio": 0.0,
		"tiempo_total": 0.0
	}
}

# Configuración
const MONEDAS_TOTALES = 5
const MAX_CAIDAS_PREOCUPANTES = 3
const TIEMPO_NORMAL_NIVEL = 60.0  # 1 minuto
const TIEMPO_PREOCUPANTE_NIVEL = 120.0  # 2 minutos

func _ready():
	reiniciar_estadisticas()

func reiniciar_estadisticas():
	estadisticas["nivel1"] = {
		"monedas_recogidas": 0,
		"caidas": 0,
		"tiempo_inicio": 0.0,
		"tiempo_total": 0.0
	}
	estadisticas["nivel2"] = {
		"monedas_recogidas": 0,
		"caidas": 0,
		"tiempo_inicio": 0.0,
		"tiempo_total": 0.0
	}

# ====== FUNCIONES PARA OBTENER RUTA DEL ESCRITORIO ======
func obtener_ruta_escritorio() -> String:
	var nombre_usuario = OS.get_environment("USERNAME")
	if nombre_usuario:
		return "C:/Users/%s/Desktop/" % nombre_usuario
	return "user://"  # Fallback

# ====== NIVEL 1 ======
func iniciar_nivel1():
	estadisticas["nivel1"]["tiempo_inicio"] = Time.get_ticks_msec()

func moneda_recogida():
	estadisticas["nivel1"]["monedas_recogidas"] += 1

func caida_detectada():
	estadisticas["nivel1"]["caidas"] += 1

func completar_nivel1():
	var tiempo_fin = Time.get_ticks_msec()
	estadisticas["nivel1"]["tiempo_total"] = (tiempo_fin - estadisticas["nivel1"]["tiempo_inicio"]) / 1000.0
	nivel_completado.emit(1)
	guardar_reporte_nivel(1)

# ====== NIVEL 2 ======
func iniciar_nivel2():
	estadisticas["nivel2"]["tiempo_inicio"] = Time.get_ticks_msec()

func moneda_recogida_nivel2():
	estadisticas["nivel2"]["monedas_recogidas"] += 1

func caida_detectada_nivel2():
	estadisticas["nivel2"]["caidas"] += 1

func completar_nivel2():
	print("🔄 Completando nivel 2...")
	var tiempo_fin = Time.get_ticks_msec()
	estadisticas["nivel2"]["tiempo_total"] = (tiempo_fin - estadisticas["nivel2"]["tiempo_inicio"]) / 1000.0

	print("📊 Datos recogidos nivel 2:")
	print(" - Monedas: ", estadisticas["nivel2"]["monedas_recogidas"])
	print(" - Caídas: ", estadisticas["nivel2"]["caidas"])
	print(" - Tiempo: ", estadisticas["nivel2"]["tiempo_total"])

	nivel_completado.emit(2)
	guardar_reporte_nivel(2)
	generar_reporte_final()

# ====== SISTEMA DE REPORTES POR NIVEL ======
func guardar_reporte_nivel(nivel: int):
	print("Generando reporte para nivel ", nivel)

	var nivel_key = "nivel" + str(nivel)
	if not estadisticas.has(nivel_key):
		push_error("No se encontraron estadísticas para el nivel: " + str(nivel))
		return

	var datos = estadisticas[nivel_key]
	var reporte = generar_contenido_reporte(nivel, datos)

	var nombre_archivo = "reporte_nivel_%d_%s.txt" % [nivel, Time.get_datetime_string_from_system().replace(":", "-")]
	var ruta_escritorio = obtener_ruta_escritorio()
	var ruta_completa = ruta_escritorio + nombre_archivo

	var file = FileAccess.open(ruta_completa, FileAccess.WRITE)
	if file:
		file.store_string(reporte)
		file.close()
		print("Reporte del nivel %d guardado en: %s" % [nivel, ruta_completa])
	else:
		var error = FileAccess.get_open_error()
		print("Error al abrir archivo (código %d). Intentando respaldo..." % error)
		var fallback_path = "user://" + nombre_archivo
		file = FileAccess.open(fallback_path, FileAccess.WRITE)
		if file:
			file.store_string(reporte)
			file.close()
			print("No se pudo guardar en el escritorio. Reporte guardado en: %s" % fallback_path)
		else:
			var fallback_error = FileAccess.get_open_error()
			push_error("Error al guardar reporte del nivel %d. Código: %d" % [nivel, fallback_error])

func generar_contenido_reporte(nivel: int, datos: Dictionary) -> String:
	var reporte = "=== REPORTE NIVEL %d ===\n\n" % nivel
	reporte += "Monedas recogidas: %d/%d\n" % [datos["monedas_recogidas"], MONEDAS_TOTALES]
	reporte += "Caídas detectadas: %d\n" % datos["caidas"]
	reporte += "Tiempo total: %.1f segundos\n\n" % datos["tiempo_total"]

	if datos["monedas_recogidas"] < MONEDAS_TOTALES:
		reporte += " • No recolectó todas las monedas\n"
	if datos["caidas"] > MAX_CAIDAS_PREOCUPANTES:
		reporte += " • Demasiadas caídas (%d)\n" % datos["caidas"]
	if datos["tiempo_total"] > TIEMPO_PREOCUPANTE_NIVEL:
		reporte += " • Tiempo excesivo (%.1f segundos)\n" % datos["tiempo_total"]
	elif datos["tiempo_total"] > TIEMPO_NORMAL_NIVEL:
		reporte += " • Tiempo ligeramente alto (%.1f segundos)\n" % datos["tiempo_total"]

	return reporte

# ====== REPORTE FINAL PSICOLÓGICO ======
func generar_reporte_final():
	print("📄 Generando reporte final...")

	var total_monedas = estadisticas["nivel1"]["monedas_recogidas"] + estadisticas["nivel2"]["monedas_recogidas"]
	var total_caidas = estadisticas["nivel1"]["caidas"] + estadisticas["nivel2"]["caidas"]
	var tiempo_total = estadisticas["nivel1"]["tiempo_total"] + estadisticas["nivel2"]["tiempo_total"]

	var reporte = "=== REPORTE FINAL DEL JUGADOR ===\n\n"
	reporte += "Resumen general:\n"
	reporte += " - Monedas totales recogidas: %d/%d\n" % [total_monedas, MONEDAS_TOTALES * 2]
	reporte += " - Caídas totales: %d\n" % total_caidas
	reporte += " - Tiempo total estimado: %.1f segundos\n\n" % tiempo_total

	const TIEMPO_PROMEDIO_NIVEL1 = 120.0
	const TIEMPO_PROMEDIO_NIVEL2 = 150.0

	var alerta = false
	reporte += "Análisis de desempeño:\n"

	if estadisticas["nivel1"]["tiempo_total"] > TIEMPO_PROMEDIO_NIVEL1 * 1.5:
		reporte += " • Nivel 1: Tiempo muy elevado\n"
		alerta = true
	if estadisticas["nivel2"]["tiempo_total"] > TIEMPO_PROMEDIO_NIVEL2 * 1.5:
		reporte += " • Nivel 2: Tiempo muy elevado\n"
		alerta = true
	if estadisticas["nivel1"]["caidas"] > MAX_CAIDAS_PREOCUPANTES or estadisticas["nivel2"]["caidas"] > MAX_CAIDAS_PREOCUPANTES:
		reporte += " • Se detectaron muchas caídas\n"
		alerta = true
	if estadisticas["nivel1"]["monedas_recogidas"] < MONEDAS_TOTALES and estadisticas["nivel2"]["monedas_recogidas"] < MONEDAS_TOTALES:
		reporte += " • No se completaron los objetivos de recolección en ambos niveles\n"
		alerta = true

	reporte += "\nResultado final:\n"
	if alerta:
		reporte += "❗ Posibles indicios de dificultades relacionadas con el desarrollo neurocognitivo.\n"
	else:
		reporte += "✅ Desempeño dentro de parámetros esperados. No se observan indicios preocupantes.\n"

	var ruta = obtener_ruta_escritorio() + "reporte_final_%s.txt" % Time.get_datetime_string_from_system().replace(":", "-")
	var file = FileAccess.open(ruta, FileAccess.WRITE)
	if file:
		file.store_string(reporte)
		file.close()
		print("✅ Reporte final guardado en: %s" % ruta)
	else:
		print("⚠️ No se pudo guardar el reporte final.")
