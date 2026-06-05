extends CharacterBody2D
var started=false
var gravity=1000
signal start
@onready var animation: AnimatedSprite2D = $animation

var jump_velocity=580



func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if started:
		animation.play("walk")
	else:
		pass	
	if not is_on_floor():
		velocity.y+=gravity* delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if started==false:
			started=true
			start.emit()
		velocity.y-=jump_velocity
		animation.play("jump")
		
	move_and_slide()	
