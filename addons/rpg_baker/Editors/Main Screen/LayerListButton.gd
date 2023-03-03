@tool
extends Button

func _ready():
	$LayerList.clear()
	for i in Database.max_sprite_layers:
		$LayerList.add_item(str(i+1))



func _on_button_down():
	$LayerList.show()
	$LayerList.position = global_position


func _on_layer_list_item_activated(index):
	$LayerList.hide()
