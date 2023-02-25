@tool
extends Control

var cur_var_list = 0
@onready var var_counters = $TabContainer/Variables/counters
@onready var switchCounters = $TabContainer/Switches/counters

enum DATA_MODE {VAR, SWITCH}
var data_mode: DATA_MODE
func _ready():
	data_mode = DATA_MODE.VAR
	if !Database.variables.is_empty():
		$TabContainer/Variables/VarCount.text = str(Database.variables.size()-1)
		_load_counters(Database.variables, var_counters)
	

func _on_var_resize_button_down():
	var new_count = 1 + int($TabContainer/Variables/VarCount.text)
	Database.variables.resize(new_count)
	Database.variable_names.resize(new_count)
	Database._clear_nulls()
	_clear_children($TabContainer/Variables/variables)
	_load_counters(Database.variables, $TabContainer/Variables/counters)
	

func _on_switch_resize_button_down():
	var new_count = 1 + int($TabContainer/Switches/SwitchCount.text)
	Database.switches.resize(new_count)
	Database.switch_names.resize(new_count)
	Database._clear_nulls()
	_clear_children($TabContainer/Switches/switches)
	_load_counters(Database.switches, $TabContainer/Switches/counters)
	

func _load_counters(list, counters):
	#load left hand side
	_clear_children(counters)
	var index = 0.0
	var column_index = 0
	var column_offset = 0
	for i in list:
		if !is_instance_valid(i):
			i = ""
		if fmod(index,Database.values_per_column) == 0:
			var new_button = preload("res://addons/rpg_baker/Editors/Docks/CounterButton.tscn").instantiate()
			var button_text = ""
			button_text = str(index + 1,"-",index + Database.values_per_column)
			new_button.text = button_text
			new_button.index = column_index
			
			counters.add_child(new_button)
			new_button.pushed.connect(_load_column)
			column_index += 1
			
		index += 1
	
	#load right hand side
func _load_column(index):
	var column_to_clear
	var list
	var data_line
	var column
	if data_mode == DATA_MODE.VAR:
		column_to_clear = $TabContainer/Variables/variables
		list = Database.variables
		data_line = preload("res://addons/rpg_baker/Editors/Docks/VarDataLine.tscn")
		column = $TabContainer/Variables/variables
	elif data_mode == DATA_MODE.SWITCH:
		column_to_clear = $TabContainer/Switches/switches
		list = Database.switches
		data_line = preload("res://addons/rpg_baker/Editors/Docks/SwitchDataLine.tscn")
		column = $TabContainer/Switches/switches
		
	_clear_children(column_to_clear)
	
	var start_point = (Database.values_per_column*index )+ 1
	var i = start_point
	for q in Database.values_per_column:
		if i >= list.size():
			return
		var new_line = data_line.instantiate()
		new_line.index = i
		i += 1
		column.add_child(new_line)
		
func _clear_children(parent):
	for i in parent.get_children():
		i.queue_free()


func _on_save_button_down():
	Database._save_defaults()




func _on_tab_container_tab_selected(tab):
	match tab:
		0: #variables
			data_mode = DATA_MODE.VAR
			if !Database.variables.is_empty():
				$TabContainer/Variables/VarCount.text = str(Database.variables.size()-1)
				_load_counters(Database.variables, var_counters)
		1: #switches
			data_mode = DATA_MODE.SWITCH
			if !Database.switches.is_empty():
				$TabContainer/Switches/SwitchCount.text = str(Database.switches.size()-1)
				_load_counters(Database.switches, $TabContainer/Switches/counters)
