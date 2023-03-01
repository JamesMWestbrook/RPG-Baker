@tool
extends Button
var item_list:ItemList
@export var item_list_path:NodePath
signal set_trait_value(key,value)
func _ready():
	item_list = get_node(item_list_path) as ItemList

func _on_button_down():
	hide()
	item_list.show()
	item_list.position = global_position
	

func _on_item_list_item_activated(index):
	text = item_list.get_item_text(index)
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
			$SpriteLayer.show()
		5: #override sprite layer
			pass
		6:
			pass
	emit_signal("set_trait_value","type",index)
	item_list.hide()
	show()


