extends Button

var var_list = ["IS", "is NOT", ">", "<", ">=", "<="]
var switch_list = ["IS", "is NOT"]
func _ready():
	_on_changed_data_type("Variable")
	
func _on_changed_data_type(type):
	$ItemList.clear()
	match type:
		"Variable":
			for i in var_list:
				$ItemList.add_item(i)
		"Switch":
			for i in switch_list:
				$ItemList.add_item(i)
	text = $ItemList.get_item_text(0)
	


func _on_button_down():
	self_modulate = Color(0,0,0,0)
	$ItemList.show()
	


func _on_item_list_item_activated(index):
	self_modulate = Color.WHITE
	$ItemList.hide()
	text = $ItemList.get_item_text(index)
