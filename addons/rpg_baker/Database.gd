@tool
extends Node

var variables = []
var variable_names = []
var switches = []
var switch_names = []
var LocalVariables = {}

var default_actors: Array[Actor]
var game_actors: Array[Actor]
var classes: Array[RPG_Class]
var max_sprite_layers = 3
var max_classes = 4

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
		"default_actors": [],
		"classes":[]
	}
	for i in default_actors:
		database.default_actors.append(i._save())
	for i in classes:
		database.classes.append(i._save())
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
	
	for actor in json_data.default_actors:
		default_actors.append(Actor.new([],[],actor.actor_name, actor.nickname,actor.profile,
			actor.instanced,actor.classes,actor.map_sprites,actor.busts,actor.battle_sprites))
	for rpg_class in json_data.classes:
			var new_class = RPG_Class.new([],rpg_class.name_of_class,rpg_class.description,
			rpg_class.map_sprites,RPG_Class.GraphicType.Image,rpg_class.busts,
			RPG_Class.GraphicType.Sprite_Frame,rpg_class.battle_sprites
			)
			var traits = _load_traits(rpg_class.traits)
			new_class.traits = traits
			classes.append(new_class)
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


func _create_class(index:int):
	var new_class = {
		"name" : "",
		"description" : "",
		"default" : true,
		"index" : index,
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
	
func _load_traits(obj):
	var traits :Array[RPG_Trait]
	var index = 0
	for i in obj:
		var new_trait = RPG_Trait.new(
			index,i.trait_type,i.class_layer,i.required_ranks
		)
		traits.append(new_trait)
		index += 1
	return traits
