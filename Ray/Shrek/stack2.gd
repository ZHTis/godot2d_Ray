extends Node
@onready var bucket = $Node2D
@onready var stoneRigidbody 
@onready var num = 6
@onready var layer = 4
@onready var floor = $TileMap/StaticBody2D/CollisionArea
@onready var button = $button/TextureButton
@onready var button2 = $button/TextureButton2
signal reward
signal noreward
signal red
@onready var ini_time
@onready var brick_pos
@onready var adge = $Area2D/CollisionShape2D

func _ready():
	get_node("/root/LevelIndex").stack_grade = 0
	build_tower(num,layer)
	floor.set_collision_layer_value(layer,true)
	var call = Callable(self,"_on_egg_entered")
	floor.body_entered.connect(call)
	button.set_position(Vector2(-100,100))
	button2.set_position(Vector2(1100,100))
	loose(num)
	judge()
	#real_or_fake(2)
	$button.hide()
	await get_tree().create_timer(0.5).timeout
	$button.show()
	ini_time = Time.get_ticks_usec()


func _input(event):
	if event is InputEventMouseButton and event.button_index == 2 :
		get_tree().change_scene_to_file("res://Shrek/stack2.tscn")
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Ini_check/click.tscn")
		

func build_tower(num,layer):
	var array = PackedVector2Array()
	for i in num:
		#print(i)
		var x = 900 + randi_range(-50,50)
		var y = 980-100*i
		var stone = preload("res://Shrek/stone.tscn").instantiate()
		stone.shape_index = 1
		# 0 is polygon, 1 is rectangle,3 is parrallel
		stone.set_position(Vector2(x,y))
		stone.layer = layer
		bucket.add_child(stone)
		array.append(Vector2(x,y))
	brick_pos =  array
	print(brick_pos)

func loose(num):
	for i in range(1,num):
		var eggs = bucket.get_child(i).get_child(0)
		eggs.set_freeze_enabled(0)


func _on_egg_entered(body):
	#print(body,'     ',body.get_groups())
	if body.is_in_group("eggs") == true:
		real_or_fake(1)
	if floor.body_entered.is_connected(call) == true:
		floor.body_entered.disconnect(call)
	if body.is_in_group("tilemap"):pass
	else:
		real_or_fake(2)

func judge():
	var c = $Node2D.get_child(bucket.get_child_count()-1)
	var d = c.get_child(0).get_global_position()
	adge.set_position(d+Vector2(105,-50))
	$Area2D/CollisionShape2D2.set_position(d-Vector2(105,50))


func real_or_fake(char):
	var realbutton = Callable(self,"real_button")
	var fakebutton = Callable(self,"fake_button")
	if char == 1:
		if button.button_down.is_connected(realbutton) == false:
			button.button_down.connect(realbutton)
		if button2.button_down.is_connected(fakebutton) == false:
			button2.button_down.connect(fakebutton)

	if char == 2: #stable
		if button.pressed.is_connected(fakebutton) == false:
			button.pressed.connect(fakebutton)
		if button2.pressed.is_connected(realbutton) == false:
			button2.pressed.connect(realbutton)
		else:pass

func real_button():
	print("correct")
	get_node("/root/LevelIndex").stack_grade = 1
	save()
	get_node("/root/LevelIndex").click_time = Time.get_ticks_usec()
	get_tree().change_scene_to_file("res://Shrek/stack2.tscn")
	emit_signal("reward")

func fake_button():
	print("nono")
	save()
	get_node("/root/LevelIndex").click_time = Time.get_ticks_usec()
	get_tree().change_scene_to_file("res://Shrek/stack2.tscn")
	emit_signal("noreward")



func trialdata():
	var trials = {
		"ini_time": ini_time,
		"click_time": get_node("/root/LevelIndex").click_time,
		"grade":get_node("/root/LevelIndex").stack_grade,
		"brick_pos": brick_pos,
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
	


func _on_area_2d_body_entered(body):
	print("enter",body)
	real_or_fake(1)

