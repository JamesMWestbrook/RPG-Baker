@tool
extends Node

var variables = []
var variable_names = []
var switches = []
var switch_names = []
var LocalVariables = {}

var default_actors = []
var game_actors = []
var classes = []
var max_sprite_layers = 3

var unit = 1
var sprite_scale = 3
var values_per_column = 20

var defaults_path = "res://data/database.json"
func _ready():
	_load_defaults()
	game_actors = default_actors.duplicate()
	
func _save_defaults():
	var database = {
		"variables" : variables,
		"variable_names" : variable_names,
		"switches" : switches,
		"switch_names" : switch_names,
		"default_actors": default_actors,
		"classes":classes
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
	default_actors = json_data.default_actors
	classes = json_data.classes
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
	_clear_null_classes()
		
			
func _create_actor(index:int):
	var new_actor = {
		"name" : "",
		"nickname" : "",
		"profile" : "",
		"default" : true,
		"index" : index,
		"classes" : [],
		"sprite" : [],
		"bust" : [],
		"battle_sprite": [],
		"stats" : {},
		"traits" : []
	}
	new_actor.classes.resize(3)
	new_actor.sprite.resize(Database.max_sprite_layers)
	new_actor.bust.resize(Database.max_sprite_layers)
	new_actor.battle_sprite.resize(Database.max_sprite_layers)
	return new_actor

func _create_class(index:int):
	var new_class = {
		"name" : "",
		"description" : "",
		"default" : true,
		"index" : index,
		"classes" : [],
		"sprite" : [],
		"bust" : [],
		"battle_sprite": [],
		"stats" : {},
		"traits" : []
	}
	new_class.sprite.resize(Database.max_sprite_layers)
	new_class.bust.resize(Database.max_sprite_layers)
	new_class.battle_sprite.resize(Database.max_sprite_layers)
	
	
	return new_class
	
func _clear_null_actors():
	var index = 0
	for i in default_actors:
		if i == null:
			print(str(index) + " is null, fixing now")
			default_actors[index] = _create_actor(index)
		index += 1
		
		
func _clear_null_classes():
	var index = 0
	for i in classes:
		if i == null:
			print(str(index) + " is null, fixing now")
			classes[index] = _create_class(index)
		index += 1
		var trait_index = 0
		for q in i.traits:
			q.index = trait_index
			trait_index += 1
