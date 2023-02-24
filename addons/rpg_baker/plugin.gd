@tool
extends EditorPlugin

var database_editor
func _enter_tree():
	# Initialization of the plugin goes here.
	database_editor = preload("res://addons/rpg_baker/Editors/Docks/Database.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, database_editor)


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_control_from_docks(database_editor)
	database_editor.free()
