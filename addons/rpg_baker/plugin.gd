@tool
extends EditorPlugin

var database_editor
var test_inspector_plugin
func _enter_tree():
	# Initialization of the plugin goes here.
	database_editor = preload("res://addons/rpg_baker/Editors/Docks/Database.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, database_editor)
	
	test_inspector_plugin = preload("res://addons/rpg_baker/Commands/TestCommInspector.gd").new()
	add_inspector_plugin(test_inspector_plugin)
	
	
func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_control_from_docks(database_editor)
	database_editor.free()
	
	remove_inspector_plugin(test_inspector_plugin)
