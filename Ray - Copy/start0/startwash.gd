extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Button.emit_signal("button_up")
	$Button.emit_signal("pressed")

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # escape 
		get_tree().change_scene_to_file("res://Ini_check/click.tscn")
	
	

func _on_button_up():
	get_tree().change_scene_to_file("res://start0/startwash.tscn")

