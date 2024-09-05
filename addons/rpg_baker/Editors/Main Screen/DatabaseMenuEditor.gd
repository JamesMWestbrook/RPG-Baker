@tool
extends Control
@export var DataRow:Panel

func _on_save_button_down():
		Database._save_defaults()
