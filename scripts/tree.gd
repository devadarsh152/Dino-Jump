extends Sprite2D

signal death

var movement_speed=250

var speed_increase=100

func _physics_process(delta: float) -> void:
	position.x-=movement_speed*delta
	if position.x<=-590:
		queue_free()




func _on_trunk_body_entered(body: Node2D) -> void:
	if body.is_in_group("dino"):
		death.emit()


func _on_speed_timer_timeout() -> void:
	movement_speed+=speed_increase
