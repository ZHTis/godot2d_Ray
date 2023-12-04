extends Node2D

@onready var path = $Path2D
@onready var p = $Path2D/PathFollow2D
var t =0

func _ready():
	pass
	#draw_track()


func _process(delta):
	t+=delta
	p.set_progress_ratio(t*0.3)
	var l 

func _draw():
	var c = Color.REBECCA_PURPLE
	draw_polyline(path.curve.get_baked_points(), c, 1, true) #check path scale if not fit


func  draw_track():
	pass
	#path.curve.add_point(Vector2(0,0), Vector2(0, 100))
	
	
