extends Node2D
@onready var shape = $RigidBody2D/CollisionPolygon2D
@onready var shape_index
@onready var layer
@onready var size = Vector2(100,100)
# Called when the node enters the scene tree for the first time.
func _ready():
	create_shape(shape_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func create_shape(some):
	var a = some
	if a == 1:
		rect_shape()
	if a == 0:
		random_shape()
	if a == 3:
		parrallel_shape()

func random_shape():
	var pointarray 
	pointarray = shape.get_polygon()
	print(pointarray,"-------")
	var x1 = randf_range(80,120)
	var y1 = randf_range(-20,20)
	pointarray.append(Vector2(x1,y1))
	var x3 = randf_range(80,120)
	var y3 = randf_range(80,120)
	pointarray.append(Vector2(x3,y3))
	var x2 = randf_range(-20,20)
	var y2 = randf_range(80,120)
	pointarray.append(Vector2(x2,y2))
	shape.set_polygon(pointarray)

func rect_shape():
	var rectshape  = RectangleShape2D.new()
	rectshape.set_size(size)
	$RigidBody2D/CollisionShape2D.set_shape(rectshape)
	$RigidBody2D.set_collision_layer_value(layer,true)
	
	var entity  = $RigidBody2D/CollisionShape2D/Sprite2D
	var position = Vector2(0,0)
	var rect2 = Rect2(position,size)
	entity.set_region_enabled(true)
	entity.set_region_rect(rect2)
	

func  parrallel_shape():
	var pointarray 
	pointarray = shape.get_polygon()
	var x1 = randf_range(80,120)
	var y1 = 0
	pointarray.append(Vector2(x1,y1))
	var x3 = randf_range(80,120)
	var y3 = 100
	pointarray.append(Vector2(x3,y3))
	var x2 = randf_range(-20,20)
	var y2 = y3
	pointarray.append(Vector2(x2,y2))
	shape.set_polygon(pointarray)
