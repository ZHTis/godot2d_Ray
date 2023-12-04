extends Node

@onready var pon = $RigidBody2D
@onready var button = $Button


var h =1040
var vel_x = 0#randf_range(200,1100)
var vel_y = 0# randf_range(0,-400)
var pos
var random_number 
var pos2 
var pos3
var force = Vector2(10000,0)
var ini_pos = Vector2(0,randf_range(0,500))
var ini_pos2 = Vector2(1920,randf_range(0,500))
var ini_time
var ball_now_pos
var trials


func _ready():
	pon.set_linear_velocity(Vector2(vel_x,vel_y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _input(event):
	if event.is_action_pressed("ui_end"): 
		get_tree().change_scene_to_file("res://joystick/level_with_joystick.tscn")
	if event is InputEventMouseButton and event.button_index ==1 :
		ball_now_pos = pon.get_position()
		print("pon now pos  ", ball_now_pos)
	if event.is_action_pressed(">"):
		pon.set_freeze_enabled(true)
	if event.is_action_pressed("<"):
		pon.set_freeze_enabled(false)
	
		
func set_ini_vel():
	var vel=0
	if Input.is_action_pressed("ui_right") :
		vel +=  
		pon.set_linear_velocity(vel)
