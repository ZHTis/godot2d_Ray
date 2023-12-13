extends Node2D

var trials
var click_pos
var click_time
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/LevelIndex").grade = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # escape 
		get_tree().change_scene_to_file("res://Ini_check/click.tscn")
	if event is InputEventMouseButton and event.button_index ==1 :
		var click_pos = event.get_position()
		get_node("/root/LevelIndex").click_time = click_time
	save()
	


func trialdata():
	trials = {
		"click_pos":get_node("/root/LevelIndex").click_pos,
		"click_time": get_node("/root/LevelIndex").click_time,
		"grade": get_node("/root/LevelIndex").grade,
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


func _on_button_pressed():
	get_node("/root/LevelIndex").grade = 1
	hide()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://start0/startred.tscn")
