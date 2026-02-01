extends Sprite2D

@onready var laser : Sprite2D = get_node("Sprite2D")

func turn_off():
	laser.visible = false
