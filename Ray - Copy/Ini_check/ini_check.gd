extends Node2D
signal click
@onready var timer = $Timer
@onready var label = $Sprite2D/Label
@onready var sprite = $Sprite2D


func _ready():
	print("Viewport Resolution is: ", get_viewport_rect().size)
	sprite.hide()
	timer.set_wait_time(0.5)
	timer.timeout.connect(hidePointer)
	label.add_theme_font_size_override("font_size",30)
	define_save_file()
	$Control.set_position(Vector2(500,500))

func _input(event):
	if event is InputEventMouseMotion:
		sprite.set_position(event.position)
		label.set_text(str(event.position))
		sprite.show()
		timer.start()
	if event is InputEventMouseButton:
		label.set_text("click!")
		print("Click time is unknown")
	if event is InputEventScreenTouch:	
		label.set_text("tap!")
	if event.is_action_pressed("ui_focus_next"): # Tab to quit game
		get_tree().quit()
	
	
	
func hidePointer():
	sprite.hide() 

func define_save_file():
	var save_file_in
	var time = Time.get_datetime_dict_from_system()
	var time_name = str(time.year) +"-"+ str(time.month) +"-"+ str(time.day) +"-"+ str(time.hour)+"."+str(time.minute)+"."+str(time.second) 
	save_file_in ="user://" +  "save_" + str(time_name) + ".csv"
	get_node("/root/LevelIndex").save_file_in = save_file_in
	print("---SAVE---", save_file_in,"----SAFE----")

