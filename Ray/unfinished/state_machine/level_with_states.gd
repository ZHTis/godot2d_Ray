extends Node

@onready var pon = $RigidBody2D
@onready var button = $Button
@onready var timer = $Timer


var h =1040
var vel_x = 968#randf_range(200,1100)
var vel_y = 0# randf_range(0,-400)
var pos
var random_number 
var pos2 
var pos3
var force = LevelIndex.force
var ini_pos = Vector2(0,randf_range(0,500))
var ini_pos2 = Vector2(1920,randf_range(0,500))
var ini_time
var ball_now_pos
var trials
var freeze_time = randf_range(0.2,1.5)

func _ready():
	pon.set_linear_velocity(Vector2(vel_x,vel_y))
	timer.start(freeze_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _input(event):
	if event.is_action_pressed("ui_end"): 
		get_tree().change_scene_to_file("res://state_machine/level_with_states.tscn")
	if event is InputEventMouseButton and event.button_index ==1 :
		ball_now_pos = pon.get_position()
		print("pon now pos  ", ball_now_pos)
	if event.is_action_pressed(">"):
		pon.set_freeze_enabled(true)
	if event.is_action_pressed("<"):
		pon.set_freeze_enabled(false)
		





func _on_timer_timeout():
	pon.set_freeze_enabled(1)
