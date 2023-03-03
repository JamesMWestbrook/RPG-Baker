@tool
extends Node
class_name Helper
static func _get_actor(index):
	return Database.game_actors[index]
	pass


static func _actor_graphics(actor_index,type:String):
	var actor = _get_actor(actor_index)
	var graphic = actor.get(type).duplicate()
	
	#for each layer check if there is a class substitute
	var layer_index = 0
	for layer in graphic:
		var traits = []
		for i in actor.classes:
			if i == -1:
				continue
			traits.append(Database.classes[i].traits.filter(func(_trait): return _trait.type == 4 and _trait.class_layer == layer_index))
			
			if !traits.is_empty():
				graphic[layer_index] = Database.classes[i].get(type)[layer_index]
		layer_index += 1
	return graphic
