@tool
extends Node
class_name Helper
static func _get_actor(index):
	return Database.game_actors[index]
	pass

static func _all_actor_traits(index,type):
	var actor = _get_actor(index)
	var traits = []
	#actor traits
	traits.append_array(actor.traits)
	#class traits
	return traits.filter(func(_trait): return _trait.type == type)

