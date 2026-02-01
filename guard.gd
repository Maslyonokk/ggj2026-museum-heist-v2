extends CharacterBody2D

@onready var timer : Timer = get_node("Timer")

signal done_being_distracted

func distracted():
	timer.start()
	print("Timer started")
	


func _on_timer_timeout() -> void:
	done_being_distracted.emit()
	print("Timer ran out")
