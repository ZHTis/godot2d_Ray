extends Node2D
@onready var slide = $StaticBody2D/CollisionPolygon2D
@onready  var path = $Path2D


func _ready():
	slide.polygon = path.curve.tessellate()


func _process(delta):
	pass

func _draw():
	var c = Color.REBECCA_PURPLE
	#draw_polyline(path.curve.get_baked_points(), c, 1, true)
	draw_colored_polygon(path.curve.get_baked_points(), c)
