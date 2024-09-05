@tool
extends EditorProperty

var RootScene = preload("res://addons/rpg_baker/Editors/Events/RootEventPage.tscn")
var EventPage = preload("res://addons/rpg_baker/Editors/Events/Commands/EventPage.tscn")

var updating = false
var root
var current_value = {
			"pages" : []
			}
var pages = []


func _init():
	root = RootScene.instantiate()
	add_child(root)
	custom_minimum_size = root.custom_minimum_size
	add_focusable(root)
	#refresh
	print(current_value)
	root.get_node("AddPageButton").pressed.connect(_new_page)
	print(current_value["pages"].size())
	
func _new_page():
	if updating:
		return
	var new_page = EventPage.instantiate()
	pages.append(new_page)
	print(current_value)
	current_value["pages"] = pages
	emit_changed(get_edited_property(), current_value)
	
func _update_property():
	var new_value = get_edited_object()[get_edited_property()]
	if current_value == null:
		current_value = {
			"pages" : []
			}
	if current_value == new_value:
		return
		
	updating = true
	current_value = new_value
	#refresh
	
	updating = false
