extends Control

signal restart

@onready var game_over_window : ColorRect = get_node("GameOverWindow")
@onready var game_won_window : ColorRect = get_node("GameWonWindow")

func game_over():
	game_over_window.visible = true

func game_won():
	game_won_window.visible = true

func _on_retry_button_pressed() -> void:
	restart.emit()

func _on_retry_button_2_pressed() -> void:
	restart.emit()
