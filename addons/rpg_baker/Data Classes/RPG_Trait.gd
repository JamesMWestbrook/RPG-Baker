extends Node
class_name RPG_Trait

enum Trait_Type {SkillType,LearnSkill,
	ModifyStat,StateResist,
	ClassOverwriteSprite}

var index : int
var trait_type : Trait_Type

#ClassOverwriteSprite
var class_layer : int

#anything on a class
var required_ranks: Array[bool]

func _init(_index = 0,
			_trait_type = Trait_Type.SkillType,
			_class_layer = 0,
			_required_ranks = []
		):
	index = _index
	trait_type = _trait_type
	class_layer = _class_layer
	required_ranks.append_array(_required_ranks)
	
func _save():
	var save = {
		"index": index,
		"class_layer" : class_layer,
		"required_ranks" : required_ranks,
		"trait_type" : trait_type
	}
	return save
