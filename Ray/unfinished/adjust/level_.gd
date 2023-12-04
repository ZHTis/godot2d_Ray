extends Node2D

@onready var target = $Button
@onready var target2 = $Button2
@onready var a = $RigidBody2D
@onready var node = $Node
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

func _ready():
	print("------------------------")
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	random_target(500)
	random_ini()
	ini_time = Time.get_ticks_usec()
	print("ini_time at  ",ini_time)



func random_target(val):
	var seed = randi_range(1,2)
	if seed ==1:
		random_number =val
	if seed ==2:
		random_number=val*-1
	else :
		pass


func random_ini():
	var seed = randi_range(1,2)
	var t1 = abs(vel_y) / 980
	var t2
	var y1 = abs(vel_y * t1 + 0.5*t1*t1*980)
	var y2 

	
	if seed == 1:
		a.set_position(ini_pos)
		a.set_linear_velocity(Vector2(vel_x,vel_y))
		y2 = y1 +985-  ini_pos.y
		t2 = sqrt(2*y2/980)
		pos = vel_x*(t1+t2)-100 #60 is half the size of the button, how much to substract depends on button size
		pos2 = pos + random_number
		pos3 = pos - random_number
		target.set_position(Vector2(pos,h))
		target2.set_position(Vector2(pos2,h))
	if seed == 2:
		a.set_position(ini_pos2)
		var vel_x2 = vel_x * (-1)
		a.set_linear_velocity(Vector2(vel_x2,vel_y))
		y2 = y1 +985-  ini_pos2.y
		t2 = sqrt(2*y2/980)
		pos = 1920 +  vel_x2*(t1+t2) -100
		pos2 = pos + random_number
		pos3 = pos - random_number
		target.set_position(Vector2(pos,h))
		target2.set_position(Vector2(pos2,h))
		print(vel_x2,"   ",vel_y)
		print(ini_pos2)
		print("button pos  ",target.get_position())


func Button2_pos():
	if target2.get_position().x >1920 and target.get_position().x <1920:
		target2.set_position(Vector2(pos3,h))
	if target2.get_position().x < 0 and target.get_position().x > 0:
		target2.set_position(Vector2(pos3,h))
	else:
		pass
		
func _process(delta):
	if Input.is_action_pressed("ui_page_up"):
		a.apply_central_force(force)
	if Input.is_action_pressed("ui_page_down"):
		a.apply_central_force(-1* force)
	else:
		pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pass#get_tree().change_scene_to_file("res://Ini_check/click.tscn")
	if event is InputEventMouseButton and event.button_index ==1 :
		ball_now_pos = a.get_position()
		print("object now pos  ", ball_now_pos)
		#save()

		
func _on_control_slidee(val):
	if a.is_freeze_enabled() == true:
		set_position(Vector2(0,val))
	else:
		pass 


func _on_control_slidef(val):
	force = Vector2(val,0)


func _on_area_2d_area_entered(area):
	pass
	


func  _on_button_pressed():
	print("correct ! ! ! ")
	#get_tree().change_scene_to_file("res://adjustScene/level_.tscn")
	

func _on_button_2_pressed():
	print("flase alarm ")
	#get_tree().change_scene_to_file("res://adjustScene/level_.tscn")



func trialdata():
	trials = {
		"ini_pos": ini_pos,
		"ini_time": ini_time,
		"click_pos":get_node("/root/LevelIndex").click_pos,
		"click_time": get_node("/root/LevelIndex").click_time,
		"ball_now_pos" : ball_now_pos,
	}
	return trials

func save():
	var file_path = get_node("/root/LevelIndex").save_file_in
	#print(file_path)
	var file
	if FileAccess.file_exists(file_path):
		file = FileAccess.open(file_path,3)
	else:
		file = FileAccess.open(file_path,7)
	#print("file exists? ",FileAccess.file_exists(file_path))
	file.seek_end()
	file.store_string("\n")
	var dat = trialdata()
	file.store_string(JSON.stringify(dat))
	file.store_string(",")
