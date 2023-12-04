extends Node2D

@onready var bucket = $stoneBucket


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	pass

func add_stone():
	var _stone = preload("res://unfinished/satck/stone.tscn")
	var stone = _stone.instantiate()
	stone.shape_index = 0
	# 0 is polygon, 1 is rectangle
	stone.get_child(0).set_freeze_enabled(0)
	stone.set_position(Vector2(500+randi_range(-20,20),0))
	bucket.add_child(stone)

func _input(event):
	if event is InputEventMouseButton:
		add_stone()
