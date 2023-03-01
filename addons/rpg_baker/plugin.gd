@tool
extends EditorPlugin

var database_value_editor
var conditional_insp_plugin

const database_panel = preload("res://addons/rpg_baker/Editors/Main Screen/Database.tscn")
var database_panel_instance

func _enter_tree():
	# Initialization of the plugin goes here.
	database_value_editor = preload("res://addons/rpg_baker/Editors/Docks/DatabaseValueEditor.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, database_value_editor)
	
	conditional_insp_plugin = preload("res://addons/rpg_baker/Commands/ConditionalInspector.gd").new()
	add_inspector_plugin(conditional_insp_plugin)
	
	database_panel_instance = database_panel.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(database_panel_instance)
	
	_make_visible(false)
	
	
	
func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_control_from_docks(database_value_editor)
	database_value_editor.free()
	
	remove_inspector_plugin(conditional_insp_plugin)
	
	if database_panel_instance:
		database_panel_instance.queue_free()

func _get_plugin_name():
	return "Database"

func _has_main_screen():
	return true

func _make_visible(visible):
	if database_panel_instance:
		database_panel_instance.visible = visible
