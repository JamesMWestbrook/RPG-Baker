extends EditorInspectorPlugin

var RootEditor = preload("res://addons/rpg_baker/Editors/Events/RootPageEditor.gd")

func _can_handle(object):
	return true
	
func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	
	if name == "EventPages":
		add_property_editor(name, RootEditor.new())
		return true
	else:
		return false
