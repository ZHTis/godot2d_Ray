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





func _on_button_pressed():
	get_tree().change_scene_to_file("res://Pon2/level3/level3.tscn")
