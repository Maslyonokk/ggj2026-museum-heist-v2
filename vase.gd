extends AnimatedSprite2D

@onready var vaseSprite : Sprite2D = get_node("Sprite2D")

func _ready() -> void:
	play("default")
	
func glass_break():
	play("breaking")

func take_vase():
	play("vase_gone")

func _on_animation_finished() -> void:
		play("glass_broken")
