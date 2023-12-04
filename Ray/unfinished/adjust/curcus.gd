extends Node2D

@onready var label = $Sprite2D/Label
@onready var sprite = $Sprite2D
@onready var clk_pos = []
@onready var clk_t = []
var click_pos
var click_time

func _input(event):
	if event is InputEventMouseMotion:
		sprite.set_position(event.position)
		label.set_text(str(event.position))
		sprite.show()
	if event is InputEventMouseButton and event.button_index ==3 :
		hide()
	if event is InputEventMouseButton and event.button_index ==2 :
		show()
	if event is InputEventMouseButton and event.button_index ==1 :
		click_pos = event.get_position()
		click_time = Time.get_ticks_usec()
		append_click()
		get_node("/root/LevelIndex").click_pos = click_pos
		get_node("/root/LevelIndex").click_time = click_time
		#print("click at  ",click_pos)
		#print("click time_usec  ",click_time)  #time since the engine started
		
func append_click():
	clk_pos.append(click_pos)
	clk_t.append(click_time)
	

