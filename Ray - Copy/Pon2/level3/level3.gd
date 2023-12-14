
extends Node2D

@onready var target = $Button # true one
@onready var target2 = $Button2 # fake one
@onready var a = $RigidBody2D

var h =850
var vel_x = 968 #randf_range(200,1100)
var vel_y = 0 #randf_range(0,-400)
##------ini_vel description------##
#(968,0)is well adjusted sobthat target button are properly calculated,
# using random somehow results in niether button catch th ball.  
##--------end--------##
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
var choice1
var choice2
var percent


func _ready():
	print("------------------------")
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	random_target(500)
	random_ini()
	physicalButtonPos()
	ini_time = Time.get_ticks_usec()
	print("ini_time at  ",ini_time)
	leafPos()
	get_node("/root/LevelIndex").pon_grade = 0
	get_node("/root/LevelIndex").enterleaftime = 0
	
	
func physicalButtonPos():
	var tx = target.get_position().x
	var tx2 = target2.get_position().x
	var w = max(tx,tx2)
	if w == tx2:
		var s2 = Shortcut.new()
		var x2 = InputEventKey.new()
		x2.keycode = 65 #a
		s2.set_events([x2])
		target2.set_shortcut(s2)
		$Button2/TextureButton2.set_shortcut(s2)
	
		var s = Shortcut.new()
		var x = InputEventKey.new()
		x.keycode = 76 #l
		s.set_events([x])
		target.set_shortcut(s)
		$Button/TextureButton.set_shortcut(s)
	if w == tx:
		var s2 = Shortcut.new()
		var x2 = InputEventKey.new()
		x2.keycode = 76 #l
		s2.set_events([x2])
		target2.set_shortcut(s2)
		$Button2/TextureButton2.set_shortcut(s2)
	
		var s = Shortcut.new()
		var x = InputEventKey.new()
		x.keycode = 65 #a
		s.set_events([x])
		target.set_shortcut(s)
		$Button/TextureButton.set_shortcut(s)
		
func leafPos():
	var x1 =  target.get_position().x
	var x2 = target2.get_position().x
	percent = randf_range(0.1,1)
	
	var x_
	if a.get_position() == ini_pos:
		x_ = x1*percent
	if a.get_position() == ini_pos2:
		x_ = (1980-x1)*(1-percent)+x1
	$leaf.pos =  Vector2(x_,0)
	
	var _x = x_
	$leaf_/CollisionShape2D.pos = Vector2(_x,0)
	
	get_node("/root/LevelIndex").percent_visible = percent
	get_node("/root/LevelIndex").leaf_size = $leaf.points
	leaf_type(0)

func leaf_type(i):
	var leaf = $leaf
	var leaf_ = $leaf_
	if i == 1:
		leaf_.set_block_signals(true)
		leaf_.hide()
	if i == 0:
		leaf.hide()
	if i == 2:
		pass


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
		choice1 =Vector2(pos,h)
		target.set_position(choice1)
		choice2 = Vector2(pos2,h)
		target2.set_position(choice2)
		get_node("/root/LevelIndex").ini_pos = ini_pos
		get_node("/root/LevelIndex").vel = Vector2(vel_x,vel_y)
			
			
	if seed == 2:
		a.set_position(ini_pos2)
		var vel_x2 = vel_x * (-1)
		a.set_linear_velocity(Vector2(vel_x2,vel_y))
		y2 = y1 +985-  ini_pos2.y
		t2 = sqrt(2*y2/980)
		pos = 1920 +  vel_x2*(t1+t2) -100
		pos2 = pos + random_number
		choice1 =Vector2(pos,h)
		target.set_position(choice1)
		choice2 = Vector2(pos2,h)
		target2.set_position(choice2)
		#print("vel  ",vel_x2,"   ",vel_y)
		get_node("/root/LevelIndex").ini_pos = ini_pos2
		get_node("/root/LevelIndex").vel = Vector2(vel_x2,vel_y)
		
		
	#print("button pos  ",target.get_position())
	get_node("/root/LevelIndex").choice1 = choice1
	get_node("/root/LevelIndex").choice2 = choice2

func _process(delta):
	if Input.is_action_pressed("ui_page_up"):
		a.apply_central_force(force)
	if Input.is_action_pressed("ui_page_down"):
		a.apply_central_force(-1* force)
	else:
		pass
	
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Ini_check/click.tscn")
	if event is InputEventMouseButton and event.button_index ==1 :
		ball_now_pos = a.get_position()
		var click_pos = event.get_position()
		var click_time = Time.get_ticks_usec()
		get_node("/root/LevelIndex").click_pos = click_pos
		get_node("/root/LevelIndex").click_time = click_time
		save()


func _on_texture_button_pressed():
	get_node("/root/LevelIndex").pon_grade = 1
	hide()
	await get_tree().create_timer(0.5).timeout
	save()
	get_tree().change_scene_to_file("res://Pon2/level3/level3.tscn")
	


func _on_texture_button_2_pressed():
	hide()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Pon2/level3/level3.tscn")



func trialdata():
	trials = {
		"ini_pos": get_node("/root/LevelIndex").ini_pos,
		"ini_time": ini_time,
		"ini_vel":get_node("/root/LevelIndex").vel,
		"click_pos":get_node("/root/LevelIndex").click_pos,
		"click_time": get_node("/root/LevelIndex").click_time,
		"ball_now_pos" : ball_now_pos,
		"choice1": get_node("/root/LevelIndex").choice1,
		"choice2":get_node("/root/LevelIndex").choice2,
		"grade":get_node("/root/LevelIndex").pon_grade,
		"percent_visible":get_node("/root/LevelIndex").percent_visible,
		"leaf_size":get_node("/root/LevelIndex").leaf_size,
		"disapear_time" :get_node("/root/LevelIndex").enterleaftime
	}
	return trials

func save():
	#-------Some description about save() -------#
	# the define_save_file() in MAin.gd define the defalut save file's name,
	# and it uses .csv, each click create a {}, if save() in the _ready(), there will be ‘null’.
	# null is not defalut as Nan in python.
	# To read in pandas,now you need to paste all the '{},{},{}...' into a var as data=[], then pd.DataFrame(data),
	# notice that null is not allowed in this method to read, and pd.read_csv doesn't recognize the {},{},{}... as it cannot seperate properly,
	# maybe json string should be modified then use .json instead of .csv
	#----------end-----------#
	var file_path = get_node("/root/LevelIndex").save_file_in
	print(file_path)
	var file
	if FileAccess.file_exists(file_path):
		file = FileAccess.open(file_path,3)
	else:
		file = FileAccess.open(file_path,7)
	#print("file exists? ",FileAccess.file_exists(file_path))
	file.seek_end()
	file.store_string("\t")
	var dat = trialdata()
	file.store_string(JSON.stringify(dat))
	file.store_string(",")
	
	





