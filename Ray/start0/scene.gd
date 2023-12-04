extends Node2D
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(0.5)
	timer.timeout.connect(on_timeout) # ignore error"signal timeout is already connected to button"



func on_timeout():
	print("renew")
	get_tree().change_scene_to_file("res://start0/start.tscn")

