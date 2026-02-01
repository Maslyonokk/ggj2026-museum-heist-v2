extends StaticBody2D

signal window_broken(pos)

@onready var animation : AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var collision : CollisionShape2D = get_node("CollisionShape2D")


func brake_window() -> void:
	animation.play()
	collision.disabled = true
	window_broken.emit(self.global_position)



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		brake_window()
