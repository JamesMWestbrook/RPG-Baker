extends Node
class_name RPG_Class

enum GraphicType {Sprite_Frame, Image}

var name_of_class : String
var description : String
var traits : Array[RPG_Trait]

var map_sprites : Array[String]
var bust_graphic_type : GraphicType
var busts : Array[String]

var battle_graphic_type : GraphicType
var battle_sprites : Array[String]


func _init(
			_traits:Array[RPG_Trait] = [RPG_Trait.new()],
			_name_of_class = "",_description = "",
			_instanced = false,
			_classes = [],
			_map_sprites = [], _bust_graphic_type = GraphicType.Image, _busts = [],
			_battle_graphic_type = GraphicType.Sprite_Frame, _battle_sprites = []
			):
	name_of_class = _name_of_class
	description = _description
	traits.append_array(_traits)
	map_sprites.append_array(_map_sprites)
	bust_graphic_type = _bust_graphic_type
	busts.append_array(_busts)
	battle_graphic_type = _battle_graphic_type
	battle_sprites.append_array(_battle_sprites)