extends EditorInspectorPlugin

func _can_handle(object):
	return object is TestCommand


func _parse_begin(object):
	var label = Label.new()
	label.text = "Example"
	add_custom_control(label)
	
	
func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	if name == "is_string":
		add_property_editor("is_string", CheckBox.new())
		return true
	else:
		return false
