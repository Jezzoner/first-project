extends CharacterBody2D

signal personaje_muerto

@export var animacion = AnimatableBody2D
@export var area_2d = Area2D
@export var material_personaje_rojo = ShaderMaterial

var _velocidad: float = 100.0
var _velocidad_salto: float = -300.0
var _muerto: bool

func _ready():
	add_to_group("personajes")
	area_2d.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta):
	if _muerto:
		return
	
	#Gravedad
	velocity += get_gravity() * delta
	
	#Salto
	if Input.is_action_just_pressed("Saltar") && is_on_floor():
		velocity.y = _velocidad_salto
	
	#Movimiento lateral
	if Input.is_action_pressed("Flecha_Derecha"):
		velocity.x = _velocidad
		animacion.flip_h = true
	elif Input.is_action_pressed("Flecha_Izquierda"):
		velocity.x = -_velocidad
		animacion.flip_h = false
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


func _on_area_2d_body_entered(_body: Node2D) -> void:
	animacion.material = material_personaje_rojo
	_muerto = true
	animacion.stop()
	await get_tree().create_timer(0.5).timeout
	personaje_muerto.emit()
