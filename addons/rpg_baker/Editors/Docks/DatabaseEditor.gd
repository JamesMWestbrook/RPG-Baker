@tool
extends Control

var cur_var_list = 0

func _ready():
	print("Ready")
	
	#variables
	if !Database.variables.is_empty():
		$TabContainer/Variables/VarCount.text = str(Database.variables.size())
		_load_counters()
	else:
		$TabContainer/Variables/VarCount.text = "0"
	
	#switches
	if !Database.switches.is_empty():
		pass
		
	else:
		pass


func _on_resize_button_down():
	var new_count = 1 + int($TabContainer/Variables/VarCount.text)
	Database.variables.resize(new_count)
	Database.variable_names.resize(new_count)
	_clear_column()
	_load_counters()
	
	
func _on_var_count_text_submitted(new_text):
	var new_count = int(new_text) + 1
	print(new_count)
	Database.variables.resize(new_count)
	Database.variable_names.resize(new_count)
	print(Database.variables.size())
	_clear_column()
	_load_counters()
	
func _load_counters():
	#load left hand side
	_clear_counters()
	var index = 0.0
	var column_index = 0
	var column_offset = 0
	for i in Database.variables:
		if !is_instance_valid(i):
			i = ""
		if fmod(index,Database.values_per_column) == 0:
			var new_button = preload("res://addons/rpg_baker/Editors/Docks/CounterButton.tscn").instantiate()
			var button_text = ""
			button_text = str(index + 1,"-",index + Database.values_per_column)
			new_button.text = button_text
			new_button.index = column_index
			
			$TabContainer/Variables/counters.add_child(new_button)
			new_button.pushed.connect(_load_column)
			column_index += 1
			
		index += 1
	
	#load right hand side
func _load_column(index):
	_clear_column()
	var start_point = (Database.values_per_column*index )+ 1
	var i = start_point
	for q in Database.values_per_column:
		if i >= Database.variables.size():
			return
		var new_line = preload("res://addons/rpg_baker/Editors/Docks/DataLine.tscn").instantiate()
		new_line.index = i
		i += 1
		$TabContainer/Variables/variables.add_child(new_line)
		
func _clear_column():
	for i in $TabContainer/Variables/variables.get_children():
		i.queue_free()
func _clear_counters():
	for i in $TabContainer/Variables/counters.get_children():
		i.queue_free()


func _on_save_button_down():
	pass # Replace with function body.


