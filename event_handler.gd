extends Node
#Script for handling communication between entities
#Responsible for transfering signals between distractions and the guard, and between the robber and his goals
 

@export var robber_speed : float = 130.0
@export var guard_speed : float = 100.0

@onready var robber : CharacterBody2D = get_node("../RobberPath/PathFollow2D/Robber")
@onready var robber_path_follow : PathFollow2D = get_node("../RobberPath/PathFollow2D")
var robber_moving : bool = true
var robber_tresspassing : bool = false
var robber_seen : bool = false

@onready var guard : CharacterBody2D = get_node("../GuardPath/PathFollow2D/Guard")
@onready var guard_path_follow : PathFollow2D = get_node("../GuardPath/PathFollow2D")
var guard_moving : bool = true
var guard_distracted : bool = false
@onready var flashlight : Sprite2D

var distraction_position : Vector2

var vase_stolen : bool = false

@onready var speaker : Area2D = get_node("../Speaker")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if robber_moving:
		robber_path_follow.progress += robber_speed * delta
	if guard_moving:
		guard_path_follow.progress += guard_speed * delta



func _on_speaker_speaker_playing() -> void:
	print("Speaker playing")
	distraction_position = speaker.get_global_position()
	print(distraction_position)
	guard_distracted = true
	guard_moving = false
	flashlight.look_at(distraction_position)


func _on_speaker_speaker_stopped() -> void:
	print("Speaker stopped")
	guard_distracted = false
	guard_moving = true
	
	
