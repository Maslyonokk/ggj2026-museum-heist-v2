extends Control

func _on_button_pressed() -> void:
	print("clicked")
	get_tree().change_scene_to_file("res://level1.tscn")
