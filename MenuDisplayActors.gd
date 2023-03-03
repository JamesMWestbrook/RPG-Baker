extends Node
#Until they put out a fix letting us specify a list of nodes
#to assign, we are doing it individually
@export var party_index:int
@export var actor_graphic:Node
var spawned_children = []
func _ready():
#	actor_graphic.sprite_frames = load(Database.game_actors[party_index].bust[0])
	var graphics = Helper._actor_graphics(0,"bust")
	var index = 0
	
	for i in Database.max_sprite_layers:
		if index == 0:
			actor_graphic.sprite_frames = load(graphics[i])
			spawned_children.append(actor_graphic)
		else:
			var new_sprite = AnimatedSprite2D.new()
			spawned_children.append(new_sprite)
			if graphics[i] != null:
				new_sprite.sprite_frames = load(graphics[i])
			else:
				new_sprite.sprite_frames = null
			actor_graphic.add_child(new_sprite)
		index += 1
