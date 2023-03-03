@tool
extends TextureRect
enum GraphicType {Map,Bust, Battle}
@export var graphic_type:GraphicType
@export var party_index:int
var spawned_children = []


func _ready():
	if Engine.is_editor_hint():
		return
	texture = null
	var graphics
	var property
	match graphic_type:
		GraphicType.Map:
			graphics = Helper._actor_graphics(party_index,"map_sprites")
			property = Helper._image_property_type("map_sprite")
		GraphicType.Bust:
			graphics = Helper._actor_graphics(party_index,"busts")
			property = Helper._image_property_type("bust")
		GraphicType.Battle:
			graphics = Helper._actor_graphics(party_index,"battle_sprites")
			property = Helper._image_property_type("battle_sprite")
	var index = 0
	
	for i in Database.max_sprite_layers:
		if index == 0:
			if graphics[i] != "":
				texture = load(graphics[i])
			else:
				texture = null
			spawned_children.append(self)
		else:
			var new_sprite = TextureRect.new()
					
			spawned_children.append(new_sprite)
			if graphics[i] != "":
				new_sprite.texture = load(graphics[i])
			else:
				new_sprite.texture = null
			add_child(new_sprite)
		index += 1
	
	for i in spawned_children:
		if property == "sprite_frames":
			i.stop()
			if i.sprite_frames != null:
				i.play("down")


func _process(delta):
	if !Engine.is_editor_hint():
		return
	if texture != null:
		return
	var graphics = []
	match graphic_type:
		GraphicType.Map:
			graphics = Helper._actor_graphics(0,"map_sprites")
		GraphicType.Bust:
			graphics = Helper._actor_graphics(0,"busts")
		GraphicType.Battle:
			graphics = Helper._actor_graphics(0,"battle_sprites")
	if graphics[0] != "":
		texture = load(graphics[0])
	else:
		texture = null
