extends Node
#Script for handling communication between entities
#Responsible for transfering signals between distractions and the guard, and between the robber and his goals
 

@export var robber_speed : float = 130.0
@export var guard_speed : float = 100.0

#All nodes and logic checks related to the robber
@onready var robber : CharacterBody2D = get_node("../RobberPath/PathFollow2D/Robber")
@onready var robber_path_follow : PathFollow2D = get_node("../RobberPath/PathFollow2D")
var robber_moving : bool = true
var robber_tresspassing : bool = false
var robber_seen : bool = false

#All nodes and logic checks related to the guard
@onready var guard : CharacterBody2D = get_node("../GuardPath/PathFollow2D/Guard")
@onready var guard_path_follow : PathFollow2D = get_node("../GuardPath/PathFollow2D")
var guard_moving : bool = true
var guard_distracted : bool = false
var guard_distracted_with_glass : bool = false #a separate check for masking the glass soung specifically
#The area inside the flashlight light is what acrtually spots the robber
@onready var flashlight : Sprite2D = get_node("../GuardPath/PathFollow2D/Guard/Flashlight")

var distraction_position : Vector2 #used to make the guard look in the right direction when there is a distraction


# Other level elements
@onready var laser : Sprite2D = get_node("../Laser")
@onready var vase : AnimatedSprite2D = get_node("../Vase")
@onready var elbox : AnimatedSprite2D = get_node("../ElectricalBox")
@onready var speaker : Area2D = get_node("../Speaker")

@onready var ui : Control = get_node("../Control")

# Game loop logic checks
var game_lost : bool = false
var glass_broke : bool = false
var vase_stolen : bool = false

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
	guard_distract(distraction_position)

func _on_speaker_speaker_stopped() -> void:
	print("Speaker stopped")
	guard_distracted = false
	if !game_lost:
		guard_moving = true
	flashlight.rotation = 0 #reset the flashlight to look forward again

# Distracted state for the guard
func guard_distract(distraction_position):
	guard_distracted = true
	guard_moving = false
	flashlight.look_at(distraction_position)
	guard.distracted()
	
#Guard goes back to normal patrolling
func guard_undistract():
	guard_distracted = false
	guard_moving = true
	flashlight.rotation = 0
	if glass_broke:
		flashlight.rotation = 3.142 #guards moves in the other direction after a window breaks, so this makes the light point in the opposite direction too
	guard_distracted_with_glass = false
	
#Signal from guards' time out on distraction time
func _on_guard_done_being_distracted() -> void:
	if !game_lost:
		guard_undistract()
		print("Guard going back to patrol after being distracted for a period of time")


func _on_flashlight_robber_spotted() -> void:
	robber_seen = true
	if robber_tresspassing:
		game_over()

#Receiving signal for leaving the area of view of the flashlight
func _on_flashlight_robber_unspotted() -> void:
	robber_seen = false


#Receiving signals of windows breaking (the next 4 are identical, for each window)
func _on_window_window_broken(pos: Variant) -> void:
	print(pos)
	distraction_position = pos
	guard_distract(distraction_position)
	guard_distracted_with_glass = true
	glass_broke = true
	guard_speed *= -1 #the guard is going the opposite way when a window breaks 
	

func _on_window_2_window_broken(pos: Variant) -> void:
	print(pos)
	distraction_position = pos
	guard_distract(distraction_position)
	guard_distracted_with_glass = true
	glass_broke = true
	guard_speed *= -1 #the guard is going the opposite way when a window breaks 


func _on_window_3_window_broken(pos: Variant) -> void:
	print(pos)
	distraction_position = pos
	guard_distract(distraction_position)
	guard_distracted_with_glass = true
	glass_broke = true
	guard_speed *= -1 #the guard is going the opposite way when a window breaks 


func _on_window_4_window_broken(pos: Variant) -> void:
	print(pos)
	distraction_position = pos
	guard_distract(distraction_position)
	guard_distracted_with_glass = true
	glass_broke = true
	guard_speed *= -1 #the guard is going the opposite way when a window breaks 


func _on_electrical_box_elbox_messed_with() -> void:
	robber_tresspassing = true
	if !guard_distracted:
		flashlight.look_at(elbox.global_position)
		if robber_tresspassing:
			game_over()


func _on_electrical_box_elbox_turned_off() -> void:
	laser.turn_off()
	robber_tresspassing = false


func break_display_case():
	robber_tresspassing = true #robber stays as tresspassing after reaching the vase
	robber_moving = false #robber stops for a moment to get the vase 
	robber.play_smash()
	vase.glass_break()
	if !guard_distracted_with_glass:
		flashlight.look_at(vase.global_position)
		game_over()

#Signal for the robber reaching the vase
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("robber"):
		break_display_case()

#Restarting the level from the UI button 
func _on_control_restart() -> void:
	get_tree().reload_current_scene()

func game_over():
	game_lost = true
	print("game over!!!!!!!!!!!!!")
	robber_moving  = false
	guard_moving = false
	#flashlight.visible = false
	#the light still shines over the UI, however it creates a nice effect of being caught. Undecided whether to leave it in or not
	ui.game_over()
	
func game_won():
	ui.game_won()

#Robber is movign back with the vase
func _on_vase_animation_finished() -> void:
	if !game_lost:
		robber_moving = true

#Robber reaching the exit
func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("robber"):
		game_won()
