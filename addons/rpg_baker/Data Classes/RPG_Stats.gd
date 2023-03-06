extends Node
class_name RPG_Stats

var dead = false

var hp :int = max_hp:
	set(val):
		if !dead:
			hp = clamp(val,0,max_hp)
		else:
			hp = 0
		if hp == 0:
			dead = true
	get:
		return hp
var max_hp :int = 5
var mp :int = max_mp:
	set(value):
		mp = clamp(value,0,max_mp)
	get:
		return mp
var max_mp :int = 5
var _str = 0
var _int = 0
var def = 0
var agi = 0

#level gains
var growth = []
static func stat_names():
	return ["HP","MP","Strength","Intellect","Defense","Agility"]
#stat growth
var lvl = 1
var exp = 0

func _init(save):
	if save:
		growth = save.growth
	else:
		growth.resize(stat_names().size())
		for i in growth.size():
			growth[i] = []
			growth[i].resize(99)
			growth[i].fill(0)
		
func _database_save():
	var save = {
		"growth" : []
	}
	for i in growth:
		save.growth.append(i)
	return save
func _ready():#explicitely for testing
	hp = -7
	mp = 6

static func _get_stat(class_index,column_index,row_index,is_actor):
	var value
	if is_actor:
		pass
	else:
		value = str(Database.classes[class_index].stats.growth[column_index][row_index])
	return value
