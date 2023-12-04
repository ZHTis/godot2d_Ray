extends Control

signal slidee(val)
signal slidef(val)

func _ready():
	$VBoxContainer/HSlider.set_max(1000)
	$VBoxContainer/HSlider2.set_max(10000)
	
func _process(delta):
	if Input.is_action_pressed("ui_home"):
		hide()
	else:
		show()

func _on_h_slider_value_changed(value):
	emit_signal("slidee",value)


func _on_h_slider_2_value_changed(value):
	emit_signal("slidef",value)
