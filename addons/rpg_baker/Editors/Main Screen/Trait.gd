@tool
extends VBoxContainer
var class_trait = false
var index = 0
signal update_trait(_trait, index)
signal deleted_trait(index)
@onready var class_panel = $Class

var _trait = {
	"type" : "0", #kind of trait it is
	"index" : 0,
	
	#class sprite layer stuff
	"class_layer" : -1,
	
	#class specific requirements
	"require_ranks" : [false,false,false,false]
}


func _ready():
	if class_trait:
		$Class.show()
	else:
		$Class.hide()
	
	#loading from database
		

func _on_delete_button_button_down():
	emit_signal("deleted_trait",index)
	queue_free()
	


func _set_trait_value(key,value):
	_trait[key] = value
	emit_signal("update_trait",_trait,index)



func _load():
	class_panel.main_class = _trait.require_ranks[0]
	class_panel.second_class = _trait.require_ranks[1]
	class_panel.third_class = _trait.require_ranks[2]
	class_panel.fourth_class = _trait.require_ranks[3]
	$Class/GridContainer/PrimaryButton.button_pressed = _trait.require_ranks[0]
	$Class/GridContainer/SecondaryButton.button_pressed = _trait.require_ranks[1]
	$Class/GridContainer/TertiaryButton.button_pressed = _trait.require_ranks[2]
	$Class/GridContainer/QuaternaryButton.button_pressed = _trait.require_ranks[3]

func _on_layer_list_item_activated(index):
	$BasicTrait/SpriteLayer.text = "Layer " + str(index)


func _on_class_required_state_change(main_class, second_class, third_class, fourth_class):
	var require_ranks = [main_class,second_class,third_class,fourth_class]
	_trait.require_ranks = require_ranks
	


func _on_item_list_item_activated(_index):
	match index:
		0: #skill type
			pass
		1: # learn skill
			pass
		2: # modify stat
			pass
		3: # state resist
			pass
		4: # class: enable class layer
			$BasicTrait/SpriteLayer.show()
		5: #override sprite layer
			pass
		6:
			pass
	_trait.type = _index
	emit_signal("update_trait",_trait,index)

