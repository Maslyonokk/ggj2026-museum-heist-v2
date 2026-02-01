extends AnimatedSprite2D

@onready var vaseSprite : Sprite2D = get_node("Sprite2D")
@onready var timer : Timer = get_node("Timer")

func _ready() -> void:
	play("default")
	
func glass_break():
	timer.start()
	
#func take_vase(): #Unused function
	#play("vase_gone")

func _on_animation_finished() -> void:
		play("vase_gone")
		vaseSprite.visible = false


func _on_timer_timeout() -> void:
	play("breaking")
