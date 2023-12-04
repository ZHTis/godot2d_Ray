extends RigidBody2D

@onready var areashape = $Area2D
signal target_pos(val)
var hit_pos
var hit_time


func _ready():
	set_freeze_enabled(0)
	set_contact_monitor(true) 

func _input(event):
	if event.is_action_pressed("ui_text_backspace"): 
		set_freeze_enabled(0)
	if event.is_action_pressed("ui_accept"): 
		set_freeze_enabled(1)
	if event.is_action_pressed("ui_end"):
		pass#get_tree().change_scene_to_file("res://adjustScene/level_.tscn")	
	else :
		pass

	# draw path?
	
	
	
func _on_area_2d_area_entered(area):
	hit_pos = get_position()
	hit_time = Time.get_ticks_usec()
	print("pon was intruded at  ",hit_pos)
	print("pon collide time  ",hit_time)
	areashape.set_collision_layer_value(1,false)
