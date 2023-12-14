extends CollisionShape2D

@onready var pos
@onready var shape_ 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func trytofit_draw():
	#----if you see this means this functionis still USELESS----#
	var a = shape_[1].x
	var b = shape_[2].y - shape_[1].y
	print(b)
	print(a)
	var size_ = Vector2(a,b)
	shape.set_size(size_)
	print(get_shape().get_size())
	set_position(pos)
	
func _draw():
	set_position(pos)
	print(pos)
