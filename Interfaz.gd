extends CanvasLayer
signal iniciar_juego

func mostrar_mensaje(texto):
	$Mensaje.text = texto
	$Mensaje.show()
	$MensajeTimer.start()

func game_over():
	mostrar_mensaje("Juego Terminado")
	yield($MensajeTimer, "timeout")
	$BotonPlay.show()
	$Mensaje.text = "Dodging In The Space"
	$Mensaje.show()

func update_score(Puntos):
	$ScoreLabel.text = str(Puntos) #convertimos a texto


func _on_MensajeTimer_timeout():
	$Mensaje.hide()
	


func _on_BotonPlay_pressed():
	$BotonPlay.hide()
	emit_signal("iniciar_juego")
