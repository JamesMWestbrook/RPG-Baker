@tool
extends Control
var current_layer = 0
var current_class = 0
var initializing = true
@onready var file_dialog = $SpriteFrameDialog
@onready var TraitRow = preload("res://addons/rpg_baker/Editors/Main Screen/Trait.tscn")
enum SPRITE_TYPES {NONE, SPRITE, BUST, BATTLE_SPRITE}
var sprite_waiting: SPRITE_TYPES


func _ready():
	_class_list()
	await get_tree().create_timer(0.01).timeout
	if Database.classes.size() > 0:
		$ScrollContainer/classlist.get_child(0).emit_signal("button_down")
	initializing = false
	
func _class_list():
	_clear_children($ScrollContainer/classlist)
	for i in Database.classes:
		_class_button(i)
	$CountLabel/ClassCount.text = str(Database.classes.size())

func _class_button(_class):
	var new_button = ButtonIndex.new()
	new_button.index = _class.index
	new_button.text = str(_class.index) + " " + _class.name
	new_button.custom_minimum_size.x = 146
	new_button.connect("button_down",new_button._on_press)
	new_button.connect("update_panel", _update_panel)
	$ScrollContainer/classlist.add_child(new_button)
	
func _on_resize_button_down():
	var new_count = int($CountLabel/ClassCount.text)
	Database.classes.resize(new_count)
	print("Resizing array. If BRAND NEW actors are null, that is to be expected and they are being formatted as blank slates.")
	Database._clear_null_classes()
	_class_list()

func _update_panel(index):
	current_layer = 0
	$"CurLayerContainer/Bust/Label/<".self_modulate = Color(0,0,0,0)
	$"CurLayerContainer/Bust/Label/</>".show()
	
	$"CurLayerContainer/Bust/Label/</LayerLabel".text = "Layer: 1"
	current_class = index
	
	var _class = Database.classes[index]
	$NameLabel/NameLineEdit.text = _class.name
	$Description/DescLineEdit.text = _class.description
	_update_all_traits()
	_get_images(index)
	
func _update_all_traits():
	_clear_children($TraitsPanel/ScrollContainer/VBoxContainer)
	for i in _get_current_class().traits:
		var loaded_trait = _on_trait_plus_button_button_down()
		loaded_trait._trait = i
		loaded_trait.get_node("BasicTrait/TraitSelection")._on_item_list_item_activated(i.type)
		loaded_trait._load()
		
func _get_images(index):
	var _class = Database.classes[index]
	#current layer preview
	var sprite = _class.sprite[current_layer]
	if sprite != null:
		$CurLayerContainer/Sprite/AnimatedSprite2D.sprite_frames = load(sprite)
	else:
		$CurLayerContainer/Sprite/AnimatedSprite2D.sprite_frames = null
		
	var bust = _class.bust[current_layer]
	if bust != null:
		$CurLayerContainer/Bust/AnimatedSprite2D.sprite_frames = load(bust)
	else:
		$CurLayerContainer/Bust/AnimatedSprite2D.sprite_frames = null
		
	var battle_sprite = _class.battle_sprite[current_layer]
	if battle_sprite != null:
		$CurLayerContainer/BattleSprite/AnimatedSprite2D.sprite_frames = load(battle_sprite)
	else:
		$CurLayerContainer/BattleSprite/AnimatedSprite2D.sprite_frames = null
		
	#all layer preview
	_full_preview(index)

func _full_preview(class_index):
	_clear_children($PreviewContainer)
	
	var _class = Database.classes[class_index]
	var index = 0
	var parent
	var root_sprite
	for i in _class.sprite:
		print(index)

		var sprite_node = AnimatedSprite2D.new()
		var sprite = _class.sprite[index]
		if sprite != null:
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
	_get_images(current_class)



func _on_index_up_button_down():
	$"CurLayerContainer/Bust/Label/<".self_modulate = Color(1,1,1,1)
	if current_layer < Database.max_sprite_layers - 1: 
		current_layer += 1
	if current_layer >= Database.max_sprite_layers - 1:
		$"CurLayerContainer/Bust/Label/</>".hide()
		
	$"CurLayerContainer/Bust/Label/</LayerLabel".text = "Layer: " + str(current_layer + 1)
	_get_images(current_class)


func _on_sprite_frame_dialog_file_selected(path):
	match sprite_waiting:
			SPRITE_TYPES.SPRITE:
				Database.classes[current_class].sprite[current_layer] = path
			SPRITE_TYPES.BUST:
				Database.classes[current_class].bust[current_layer] = path
			SPRITE_TYPES.BATTLE_SPRITE:
				Database.classes[current_class].battle_sprite[current_layer] = path
				
	_get_images(current_class)

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
	Database.classes[current_class].name = new_text


func _on_desc_line_edit_text_changed():
	Database.classes[current_class].description = $Description/DescLineEdit.text


func _on_sprite_x_button_down():
	pass # Replace with function body.
	Database.classes[current_class].sprite[current_layer] = null
	_update_panel(current_layer)


func _on_trait_plus_button_button_down():
	var new_trait = TraitRow.instantiate()
	#_get_current_class().traits += new_trait._trait
	new_trait.class_trait = true
	$TraitsPanel/ScrollContainer/VBoxContainer.add_child(new_trait)
	new_trait.index = $TraitsPanel/ScrollContainer/VBoxContainer.get_children().rfind(new_trait)
	new_trait._trait.index = new_trait.index
	new_trait.connect("update_trait",_update_trait)
	if !initializing:
		_get_current_class().traits.append(new_trait._trait)
	return new_trait

func _get_current_class():
	return Database.classes[current_class]
	
func _update_trait(_trait,index):

	_get_current_class().traits[index] = _trait
