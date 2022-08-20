extends Node

export(PackedScene) var Roca
var Score

func _ready():
	randomize()
	
func nuevo_juego():
	Score = 0
	$Player.inicio($PosicionDeInicio.position) #Pos de inicio del player
	$InicioTimer.start()
	$Interfaz.mostrar_mensaje("Listo!")
	$Interfaz.update_score(Score)
	$AudioJuego.play()

func game_over(): #Desactivamos el tiempo de creado de rocas y el score
	$ScoreTimer.stop()
	$RocaTimer.stop()
	$Interfaz.game_over()
	$AudioMuerte.play()
	$AudioJuego.stop()

func _on_InicioTimer_timeout(): #Creamos rocas y iniciamos el score
	$RocaTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout(): #Sumamos 1seg para el score
	Score += 1
	$Interfaz.update_score(Score)
	#pass

func _on_RocaTimer_timeout():
	#Seleciona un lugar aleatorio para crear la roca
	$Camino/RocaPosicion.set_offset(randi())
	var R = Roca.instance() #Creamos un objeto Roca
	add_child(R)
	
	var d = $Camino/RocaPosicion.rotation + PI/2 #Selecciona una direccion
	
	R.position = $Camino/RocaPosicion.position #EStablecemos la posicion de la roca en la del camino
	d += rand_range(-PI/4, PI/4)
	R.rotation = d
	R.set_linear_velocity(Vector2(rand_range(R.velocidad_min, R.velocidad_max), 0).rotated(d))
	
	
	
