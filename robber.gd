extends CharacterBody2D

@onready var animation : AnimatedSprite2D = get_node("AnimatedSprite2D")

signal done_smashing

func play_smash():
	animation.play("smash")
	
func play_stolen():
	animation.play("stolen")



func _on_animated_sprite_2d_animation_finished() -> void:
		play_stolen()
	
