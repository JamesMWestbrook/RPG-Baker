@tool
extends Label
signal name_changed(index, new_name)
signal value_changed(index, value)
var index = 0

func _ready():
	text = str(index)
	$name.text = Database.variable_names[index]
	
func _on_name_text_changed(new_text):
	emit_signal("name_changed",index, new_text)
	Database.variable_names[index] = new_text
	

func _on_value_text_changed(new_text):
	emit_signal("value_changed",index,new_text)
