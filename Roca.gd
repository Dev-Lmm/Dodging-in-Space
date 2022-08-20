extends RigidBody2D

export(int) var velocidad_min
export(int) var velocidad_max
var tipo_roca = ["Roca1", "Roca2"]

func _ready():
	$AnimatedSprite.animation = tipo_roca[randi() % tipo_roca.size()]
	
func _on_Visibilidad_screen_exited():
	queue_free() #Elimina la roca si sale de la pantalla
