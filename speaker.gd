extends Area2D

signal speaker_playing

signal speaker_stopped


@onready var animation : AnimatedSprite2D = get_node("AnimatedSprite2D")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				animation.play()
				speaker_playing.emit()
			else:
				animation.stop()
				speaker_stopped.emit()



func _on_mouse_exited() -> void:
	animation.stop()
	speaker_stopped.emit()
