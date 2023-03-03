extends Node
class_name Actor

enum GraphicType {Sprite_Frame, Image}

var actor_name : String
var nickname : String
var profile : String
var instanced : bool = false
var classes : Array[int]
var traits : Array[RPG_Trait]

var map_sprites : Array[String]
var bust_graphic_type : GraphicType
var busts : Array[String]

var battle_graphic_type : GraphicType
var battle_sprites : Array[String]

var stats : Array[RPG_Stats]

func _init(
			_traits:Array[RPG_Trait] = [RPG_Trait.new()],
			_stats:Array[RPG_Stats] = [RPG_Stats.new()],
			_actor_name = "",_nickname = "",_profile = "",
			_instanced = false,
			_classes = [],
			_map_sprites = [],_busts = [],
			_battle_sprites = []
			):
	actor_name = _actor_name
	nickname = _nickname
	profile = _profile
	for i in _classes:
		classes.append(int(i))
	traits.append_array(_traits)
	map_sprites.append_array(_map_sprites)
	busts.append_array(_busts)
	battle_sprites.append_array(_battle_sprites)
	stats.append_array(_stats)
	
	
	if classes.is_empty():
		classes.resize(Database.max_classes)
		classes.fill(-1)
	if map_sprites.is_empty():
		map_sprites.resize(Database.max_sprite_layers)
	if busts.is_empty():
		busts.resize(Database.max_sprite_layers)
	if battle_sprites.is_empty():
		battle_sprites.resize(Database.max_sprite_layers)
func _save():
	var save = {
		"actor_name" : actor_name,
		"nickname" : nickname,
		"profile" : profile,
		"instanced" : instanced,
		"classes" : classes,
		"traits" : [],
		"map_sprites" : map_sprites,
		"busts" : busts,
		"battle_graphic_type" : battle_graphic_type,
		"battle_sprites" : battle_sprites
	}
	return save

