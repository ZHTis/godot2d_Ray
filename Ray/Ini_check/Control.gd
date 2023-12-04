extends Control
@onready var button = $VBoxContainer/Button 
@onready var button2 = $VBoxContainer/Button2
@onready var button3 = $VBoxContainer/Button3 
@onready var button4 = $VBoxContainer/Button4
@onready var button5 = $VBoxContainer/Button5
@onready var button6 = $VBoxContainer/Button6

func _ready():
	button6.set_text("level3_Pon2")
	button6.add_theme_font_size_override("font_size",80)
	button6.pressed.connect(_button6)
	
	button5.set_text("start 0")
	button5.pressed.connect(_button5)
	button5.add_theme_font_size_override("font_size",80)
	
	button4.set_text("Pleco")
	button4.pressed.connect(_button4)
	button4.add_theme_font_size_override("font_size",80)
	
	button3.add_theme_font_size_override("font_size",80)
	button3.set_text("fullguess")
	button3.pressed.connect(_button3)
	
	button2.add_theme_font_size_override("font_size",80)
	button2.set_text("Shrek")
	button2.pressed.connect(_button2)
	
	button.add_theme_font_size_override("font_size",80)
	button.set_text("Pon2")
	button.pressed.connect(_button)



func _button():
	get_tree().change_scene_to_file("res://Pon2/start_pon.tscn")
		

func _button2():
	get_tree().change_scene_to_file("res://Shrek/stack2.tscn")

func _button3():
	get_tree().change_scene_to_file("res://Pon2/level0/fullguess.tscn")
	button3.add_theme_font_size_override("font_size",300)
	button.remove_theme_font_size_override("font_size")
	button2.remove_theme_font_size_override("font_size")

func _button4():
	get_tree().change_scene_to_file("res://start0/startwash.tscn")

func _button5():
	get_tree().change_scene_to_file("res://start0/start.tscn")
func _button6():
	get_tree().change_scene_to_file("res://Pon2/level3/start_pon(1).tscn")

func _input(event):
	if event.is_action_pressed("ini_check1"):
		_button5()
	if event.is_action_pressed("ini_check2"):
		_button()
	if event.is_action_pressed("ini_check3"):
		_button6()
	if event.is_action_pressed("ini_check4"):
		_button2()
	if event.is_action_pressed("ini_check0"):
		_button4()

