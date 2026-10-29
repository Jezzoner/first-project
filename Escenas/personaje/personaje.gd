extends CharacterBody2D

@export var animacion = AnimatableBody2D

var _velocidad: float = 100.0
var _velocidad_salto: float = -300.0

func _physics_process(delta):
	#Gravedad
	velocity += get_gravity() * delta
	
	#Salto
	if Input.is_action_just_pressed("ui_accept") && is_on_floor():
		velocity.y = _velocidad_salto
	
	#Movimiento
	if Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -_velocidad
	else:
		velocity.x = 0
	move_and_slide()

	#Animacion
	if !is_on_floor():
		animacion.play("saltar")
	elif velocity.x != 0:
		animacion.play("correr")
	else:
		animacion.play("idle")
