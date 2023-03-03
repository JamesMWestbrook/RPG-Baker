@tool
extends Control
@onready var ActorList = $ScrollContainer/actorlist
var current_layer = 0
var current_actor = 0

@onready var file_dialog = $SpriteFrameDialog
var pick_class_button = preload("res://addons/rpg_baker/Editors/Main Screen/pick_class.tscn")
enum SPRITE_TYPES {NONE, SPRITE, BUST, BATTLE_SPRITE}
var sprite_waiting: SPRITE_TYPES


func _ready():
	_actor_list()
	await get_tree().create_timer(0.01).timeout
	if Database.default_actors.size() > 0:
		$ScrollContainer/actorlist.get_child(0).emit_signal("button_down")
	for i in Database.max_classes:
		var new_button = pick_class_button.instantiate()
		new_button.slot_index = i
		new_button.name = str(i)
		new_button.connect("assign_class",_assign_class)
		$ClassesGrid.add_child(new_button)
	_update_panel(0)
func _actor_list():
	_clear_children($ScrollContainer/actorlist)
	var index = 0
	for i in Database.default_actors:
		_actor_button(i,index)
		index += 1
	$CountLabel/ActorCount.text = str(Database.default_actors.size())

func _actor_button(actor,button_index):
	var new_button = ButtonIndex.new()
	new_button.index = button_index
	new_button.text = str(button_index) + " " + actor.actor_name
	new_button.custom_minimum_size.x = 146
	new_button.connect("button_down",new_button._on_press)
	new_button.connect("update_panel", _update_panel)
	$ScrollContainer/actorlist.add_child(new_button)
	
func _on_resize_button_down():
	var new_count = int($CountLabel/ActorCount.text)
	Database.default_actors.resize(new_count)
	for i in new_count:
		if Database.default_actors[i] == null:
			Database.default_actors[i] = Actor.new()
	print("Resizing array. If BRAND NEW actors are null, that is to be expected and they are being formatted as blank slates.")
	#Database._clear_null_actors()
	_actor_list()

func _update_panel(index):
	current_layer = 0
	$"CurLayerContainer/Bust/Label/<".self_modulate = Color(0,0,0,0)
	$"CurLayerContainer/Bust/Label/</>".show()
	
	$"CurLayerContainer/Bust/Label/</LayerLabel".text = "Layer: 1"
	current_actor = index
	if Database.default_actors.is_empty():
		return
	var actor = Database.default_actors[index]
	$NameLabel/NameLineEdit.text = actor.name
	$Nickname/NickLineEdit.text = actor.nickname
	$Profile/ProfileLineEdit.text = actor.profile
	
	_get_images(index)
	var _index = 0
	for i in $ClassesGrid.get_children():
		i._on_item_list_item_activated(actor.classes[_index],true)
		_index += 1


func _get_images(index):
	var actor = Database.default_actors[current_actor]
	#current layer preview
	if !actor.map_sprites.is_empty():
		var sprite = actor.map_sprites[current_layer]
		if sprite != "":
			$CurLayerContainer/Sprite/AnimatedSprite2D.sprite_frames = load(sprite)
		else:
			$CurLayerContainer/Sprite/AnimatedSprite2D.sprite_frames = null
	
	if !actor.busts.is_empty():
		var bust = actor.busts[current_layer]
		if bust != "":
			$CurLayerContainer/Bust/AnimatedSprite2D.sprite_frames = load(bust)
		else:
			$CurLayerContainer/Bust/AnimatedSprite2D.sprite_frames = null
		
	if !actor.battle_sprites.is_empty():
		var battle_sprite = actor.battle_sprites[current_layer]
		if battle_sprite != "":
			$CurLayerContainer/BattleSprite/AnimatedSprite2D.sprite_frames = load(battle_sprite)
		else:
			$CurLayerContainer/BattleSprite/AnimatedSprite2D.sprite_frames = null
		
	#all layer preview
	_full_preview()
	
func _full_preview():
	_clear_children($PreviewContainer)
	
	var actor = GActor()
	var index = 0
	var parent
	var root_sprite
	for i in actor.map_sprites:
		print(index)

		var sprite_node = AnimatedSprite2D.new()
		var sprite = actor.map_sprites[index]
		if sprite != "":
			sprite_node.sprite_frames = load(sprite)

		if index == 0:
			parent = $PreviewContainer
			root_sprite = sprite_node
		else:
			parent = root_sprite
		parent.add_child(sprite_node)
		index += 1

func _clear_children(node):
	for i in node.get_children():
		i.queue_free()
func _on_index_down_button_down():
	$"CurLayerContainer/Bust/Label/</>".show()
	
	if current_layer > 0:
		current_layer -= 1
	if current_layer <= 0:
		$"CurLayerContainer/Bust/Label/<".self_modulate = Color(0,0,0,0)
		
	$"CurLayerContainer/Bust/Label/</LayerLabel".text = "Layer: " + str(current_layer + 1)
	_get_images(current_actor)



func _on_index_up_button_down():
	$"CurLayerContainer/Bust/Label/<".self_modulate = Color(1,1,1,1)
	if current_layer < Database.max_sprite_layers - 1: 
		current_layer += 1
	if current_layer >= Database.max_sprite_layers - 1:
		$"CurLayerContainer/Bust/Label/</>".hide()
		
	$"CurLayerContainer/Bust/Label/</LayerLabel".text = "Layer: " + str(current_layer + 1)
	_get_images(current_actor)


func _on_sprite_frame_dialog_file_selected(path):
	match sprite_waiting:
			SPRITE_TYPES.SPRITE:
				Database.default_actors[current_actor].map_sprites[current_layer] = path
			SPRITE_TYPES.BUST:
				Database.default_actors[current_actor].bust[current_layer] = path
			SPRITE_TYPES.BATTLE_SPRITE:
				Database.default_actors[current_actor].battle_map_sprites[current_layer] = path
				
	_get_images(current_layer)

func _on_sprite_button_down():
	sprite_waiting = SPRITE_TYPES.SPRITE
	file_dialog.show()


func _on_bust_button_down():
	sprite_waiting = SPRITE_TYPES.BUST
	file_dialog.show()


func _on_battle_sprite_button_down():
	sprite_waiting = SPRITE_TYPES.BATTLE_SPRITE
	file_dialog.show()


func _on_name_line_edit_text_changed(new_text):
	Database.default_actors[current_actor].actor_name = new_text
func _on_nick_line_edit_text_changed(new_text):
	Database.default_actors[current_actor].nickname = new_text
func _on_profile_line_edit_text_changed():
	Database.default_actors[current_actor].profile = $Profile/ProfileLineEdit.text
	
func _assign_class(class_slot,assigned_class):
	Database.default_actors[current_actor].classes[class_slot] = assigned_class

func GActor():
	return Database.default_actors[current_actor]
