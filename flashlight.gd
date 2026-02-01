extends Sprite2D

signal robber_spotted
signal robber_unspotted




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("robber"):
		robber_spotted.emit()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("robber"):
		robber_unspotted.emit()
