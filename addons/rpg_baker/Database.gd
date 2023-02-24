@tool
extends Node

var variables = []
var variable_names = []
var switches: Array[bool]
var LocalVariables = {}

var unit = 1
var values_per_column = 20

var defaults_path = "res://data/database.json"

func _save_defaults():
	var database = {
		"variables" : variables,
		"variable_names" : variable_names,
		"switches" : switches
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
	_clear_nulls()
	
func _clear_nulls():
	var index = 0
	print("Variables")
	for i in variables:
		if i == null:
			print("Invalid " + str(index))
			variables[index] = ""
		index += 1
	index = 0
	print("Variable Names")
	
	for i in variable_names:
		if i == null:
			print("Invalid " + str(index))
			variable_names[index] = ""
		index += 1
