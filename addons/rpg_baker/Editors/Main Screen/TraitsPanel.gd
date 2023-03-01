@tool
extends Panel

@onready var TraitRow = preload("res://addons/rpg_baker/Editors/Main Screen/Trait.tscn")

func _on_plus_button_button_down():
	$ScrollContainer/VBoxContainer.add_child(TraitRow.instantiate())

