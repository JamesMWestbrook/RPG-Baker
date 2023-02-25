@tool
extends Node

var variables = []
var variable_names = []
var switches = []
var switch_names = []
var LocalVariables = {}

var unit = 1
var values_per_column = 20

var defaults_path = "res://data/database.json"
func _ready():
	_load_defaults()
	
	
func _save_defaults():
	var database = {
		"variables" : variables,
		"variable_names" : variable_names,
		"switches" : switches,
		"switch_names" : switch_names
	}
	var file = FileAccess.open("res://data/database.json", FileAccess.WRITE)
	var json_string = JSON.stringify(database)
	file.store_string(json_string)

func _load_defaults():
	var dir_access = DirAccess.open("res://data")
	if !dir_access.file_exists("res://data/database.json"):
		return
	var json_file = FileAccess.get_file_as_string("res://data/database.json")
	var json_data = JSON.parse_string(json_file)
	variables = json_data.variables
	variable_names = json_data.variable_names
	switches = json_data.switches
	switch_names = json_data.switch_names
	_clear_nulls()
	
func _clear_nulls():
	var index = 0
	for i in variables:
		if i == null:
			print("Invalid " + str(index))
			variables[index] = ""
		index += 1
	index = 0
	
	for i in variable_names:
		if i == null:
			print("Invalid " + str(index))
			variable_names[index] = ""
		index += 1
	
	#switches
	index  = 0
	for i in switches:
		if i == null:
			print("Invalid Switch " + str(index))
			switches[index] = false
		index += 1
	index = 0
	for i in switch_names:
		if i == null:
			print("Invalid Switch Name " + str(index))
			switch_names[index] = ""
		index += 1
			
