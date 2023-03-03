@tool
extends Button
class_name ButtonIndex
signal update_panel(index)

var index = 0

func _on_press():
	emit_signal("update_panel", index)
