extends Area2D 
#Agrega la vareable Velocidad a mi Script
export(int) var Velocidad #controla la velocidad del movimiento
var Movimiento = Vector2() #controla los movimiento
var limite
signal golpe

func _ready():
	hide() #Escondemos el personaje al iniciar el juego
	limite = get_viewport_rect().size # Limitamos para no salir del margen 


func _process(delta):
	#Reiniciamos el movimiento para evitar que el movimiento quede pegado
	Movimiento = Vector2()
	
	#Verificamos la accion dependiendo de la tecla presionada
	if Input.is_action_pressed("ui_right"):
		Movimiento.x += 1
	if Input.is_action_pressed("ui_left"):
		Movimiento.x -= 1
	if Input.is_action_pressed("ui_down"):
		Movimiento.y += 1
	if Input.is_action_pressed("ui_up"):
		Movimiento.y -= 1
	#Verfica si ya se esta moviendo
	if Movimiento.length() > 0:
		#Normaliza la velocidad
		Movimiento = Movimiento.normalized() * Velocidad 
		
	position += Movimiento * delta #Actualiza los movimiento
	position.x = clamp(position.x, 100, limite.x-115)
	position.y = clamp(position.y, 90, limite.y-90)
	
	if Movimiento.x != 0:
		$Sprite_player.animation = "LadoN2"
		$Sprite_player.flip_h = Movimiento.x < 0
	elif Movimiento.y != 0:
		$Sprite_player.animation = "ArribaN2"
		$Sprite_player.flip_v = Movimiento.y > 0
	else:
		$Sprite_player.animation = "ArribaN2"

#Valida la colicion con algun cuerpo
func _on_Player_body_entered(_body):
	$CollisionShape2D.disabled = true
	emit_signal("golpe")
	hide()
	
	
func inicio(pos):
	$CollisionShape2D.disabled = false
	position = pos
	show() #Mostramos personaje
	
	
	
