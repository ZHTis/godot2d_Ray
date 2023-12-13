extends RigidBody2D


var force = LevelIndex.force

func _ready():
	set_freeze_enabled(0)

	
func _input(event):
	if event.is_action_pressed("ui_text_backspace"): 
		set_freeze_enabled(0)
	## RESTART 
	if event.is_action_pressed("ui_end"):
		get_tree().change_scene_to_file("res://Pon2/level3.tscn")
	else :
		pass
	
func _process(delta):
	if Input.is_action_pressed("ui_page_up"):
		apply_central_force(force)
	if Input.is_action_pressed("ui_page_down"):
		apply_central_force(-1* force)
	else :
		pass
	
	


