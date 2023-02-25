extends EditorInspectorPlugin

var conditional_scene = preload("res://addons/rpg_baker/Editors/Conditional.tscn")
func _can_handle(object):
	#return object is Conditional
	return false
	
func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	if !object is Conditional:
		return false
	var scene = conditional_scene.instantiate()
	add_property_editor_for_multiple_properties("Test",[],scene)
	return true
