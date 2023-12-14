extends Control
@onready var button = $VBoxContainer/Button 
@onready var button2 = $VBoxContainer/Button2
@onready var button3 = $VBoxContainer/Button3 
@onready var button4 = $VBoxContainer/Button4
@onready var button5 = $VBoxContainer/Button5
@onready var button6 = $VBoxContainer/Button6
@onready var button7 = $VBoxContainer/Button7

func _ready():
	button6.set_text("green/red")
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
	button2.set_text("yellows")
	button2.pressed.connect(_button2)
	
	button.add_theme_font_size_override("font_size",80)
	button.set_text("Pon3")
	button.pressed.connect(_button)
	
	button7.add_theme_font_size_override("font_size",80)
	button7.set_text("Pon2")
	button7.pressed.connect(_button7)



func _button():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Pon2/level3/level3.tscn")
	
func _button7():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Pon2/level2.tscn")
	
func _button2():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://start0/startred.tscn")

func _button3():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Pon2/level0/level0.tscn")
	button3.add_theme_font_size_override("font_size",300)
	button.remove_theme_font_size_override("font_size")
	button2.remove_theme_font_size_override("font_size")

func _button4():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://start0/startwash.tscn")

func _button5():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://start0/start2.tscn")
func _button6():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://start0/startgreen.tscn")

func _input(event):
	if event.is_action_pressed("ini_check1"):
		_button3()
	if event.is_action_pressed("ini_check2"):
		_button()
	if event.is_action_pressed("ini_check3"):
		_button6()
	if event.is_action_pressed("ini_check4"):
		_button2()
	if event.is_action_pressed("ini_check0"):
		_button4()

