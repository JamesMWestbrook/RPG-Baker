extends Node
#Until they put out a fix letting us specify a list of nodes
#to assign, we are doing it individually

enum GraphicType {Map,Bust, Battle}
@export var graphic_type:GraphicType
@export var party_index:int
@export var actor_graphic:Node
var spawned_children = []


func _ready():
	var graphics
	var property
	match graphic_type:
		GraphicType.Map:
			graphics = Helper._actor_graphics(0,"map_sprites")
			property = Helper._image_property_type("map_sprite")
		GraphicType.Bust:
			graphics = Helper._actor_graphics(0,"busts")
			property = Helper._image_property_type("bust")
		GraphicType.Battle:
			graphics = Helper._actor_graphics(0,"battle_sprites")
			property = Helper._image_property_type("battle_sprite")
	var index = 0
	
	for i in Database.max_sprite_layers:
		if index == 0:
			if graphics[i] != "":
				actor_graphic.set(property,load(graphics[i])) 
			else:
				actor_graphic.set(property,null)
			spawned_children.append(actor_graphic)
		else:
			var new_sprite
			match property:
				"sprite_frames":
					new_sprite = AnimatedSprite2D.new()
				"texture":
					new_sprite = TextureRect.new()
					
			spawned_children.append(new_sprite)
			if graphics[i] != "":
				new_sprite.set(property,load(graphics[i]))
			else:
				new_sprite.set(property,null)
			actor_graphic.add_child(new_sprite)
		index += 1
	
	for i in spawned_children:
		if property == "sprite_frames":
			i.stop()
			if i.sprite_frames != null:
				i.play("down")
