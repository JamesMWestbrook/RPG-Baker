@tool
extends Button
signal pushed(counter)


var index = 0
func _on_button_down():
	emit_signal("pushed", index)
