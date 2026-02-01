extends Area2D

signal speaker_playing

signal speaker_stopped


@onready var animation : AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var timer : Timer = get_node("Timer")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		animation.play()
		speaker_playing.emit()
		timer.start()

				#animation.stop()
				#speaker_stopped.emit()



func _on_mouse_exited() -> void:
	pass

	
	


func _on_timer_timeout() -> void:
	animation.stop()
	speaker_stopped.emit()
