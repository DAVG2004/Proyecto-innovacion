# Proyecto-innovacion


Este prototipo de videojuego interactivo orientado a niños de entre 4 y 10 años permite registrar patrones de comportamiento asociados a posibles indicadores de TND. Este videojuego busca funcionar como herramienta complementaria al proceso clínico, ofreciendo un medio accesible, amigable y automatizado para la observación inicial de rasgos comportamentales relevantes.

Cómo funciona:
Inicialmente, se le presenta una instancia al jugador donde podrá ver distintas opciones, entre ellas:

Las instrucciones para entender cómo moverse por el mapa
*Un botón de salida para cerrar el juego
*Y una opción para iniciar el juego
*Luego de que el jugador/paciente inicia el juego, se le presentarán 2 niveles que se encargan de obtener ciertos datos para poder generar el diagnóstico preliminar que se busca.

El primer nivel se encarga de ver cuánto tarda el jugador en llegar a un objetivo, teniendo distintos obstáculos en el camino. Durante todo ese proceso, en el escenario se encontrarán algunos elementos adicionales (monedas, en este caso) que buscan captar la atención del jugador. Las métricas obtenidas en este nivel son nada más:

*Cantidad de veces que el jugador cae.
*Número de monedas recolectadas.
*Tiempo que tarda en completar el nivel.

Estos datos del nivel 1 se mantienen y se guardan en un reporte.txt para que el encargado de hacer el análisis pueda observar cuáles fueron sus resultados en este primer nivel.

El nivel 2 se encarga de ver cuánto tiempo tarda el jugador en encontrar y entender que debe colocar objetos específicos (cajas) en sus lugares asignados. Al colocar todas las cajas en su lugar, se activa una imagen de una corona que, al entrar en contacto con el jugador, termina el nivel 2 directamente y pasa los resultados. Una vez termina el nivel 2, todos los datos obtenidos se guardan también en un reporte.txt para facilidad del encargado de tratar el caso del paciente. En este nivel, las métricas a medir son:

*Tiempo que tarda en completar el nivel.

A diferencia del nivel 1, que obtiene datos de las caídas y las monedas recolectadas, aquí buscamos saber cuánto le toma al jugador entender lo que tiene que hacer y completarlo. Si el tiempo de completado se encuentra dentro del promedio general, se puede decir que no hay ninguna señal alarmante en el paciente; en cambio, si sobrepasa este tiempo promedio, se toma como un dato para generar el análisis preliminar.

Una vez terminado el juego, se presenta una última pantalla que felicita y agradece al jugador por su participación en el mismo. Se le da la opción de terminar, lo que lo devolverá al menú inicial, donde decidirá si volver a iniciar, leer las instrucciones o cerrar el juego.

En paralelo a todos los procesos, un controlador se encarga de recolectar los datos importantes de cada nivel. Este controlador, aparte de guardar dichos datos, también se encarga de crear el diagnóstico preliminar, esto con la intención de que el responsable de tratar al paciente pueda tener una idea de a qué se va a enfrentar y cómo tratar de forma más directa al paciente, sin necesidad de una primera sesión de terapia donde busque ver si realmente el paciente está o no en alguno de los espectros.

Aclaración importante:
Este es un proyecto de carácter universitario que busca únicamente convertirse en una herramienta capaz de ayudar al diagnóstico de pacientes que posean alguno de los trastornos de neurodesarrollo. No debe tomarse como una herramienta que determine en el 100% de los casos la presencia de los mismos. Este proyecto busca únicamente dar un diagnóstico preliminar para facilitar el análisis y la aplicación de un tratamiento a manos de un profesional en el área.
