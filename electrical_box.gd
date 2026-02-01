extends AnimatedSprite2D

@onready var area : Area2D = get_node("Area2D")
@onready var timer : Timer = get_node("Timer")

signal elbox_turned_off

func _ready() -> void:
	play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("robber"):
		timer.start()
		speed_scale = 5

func _on_timer_timeout() -> void:
	elbox_turned_off.emit()
	stop()
	
