@tool
extends Label
signal name_changed(index, new_name)
signal value_changed(index, value)
var index = 0

func _ready():
	text = str(index)
	#if!is_instance_valid(Database.variable_names[index]):
#		Database.variable_names[index] = ""
	$name.text = Database.switch_names[index]
#	if!is_instance_valid(Database.variables[index]):
	#	Database.variables[index] = ""
	$CheckBox.button_pressed = Database.switches[index]
	
	
func _on_name_text_changed(new_text):
	emit_signal("name_changed",index, new_text)
	Database.switch_names[index] = new_text
	



func _on_check_box_toggled(button_pressed):
	emit_signal("value_changed", button_pressed)
	Database.switches[index] = button_pressed
