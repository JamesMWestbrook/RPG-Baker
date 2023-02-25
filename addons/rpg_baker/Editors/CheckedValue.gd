extends Button

enum DATATYPE {VAR, SWITCH, NONE}
var datatype:DATATYPE
@onready var item_list = $ItemList

func _ready():
	_update("Variable")

func _on_item_list_item_activated(index):
	pass
	get_child(0).hide()
	self_modulate = Color.WHITE
	var list
	match datatype:
		DATATYPE.VAR:
			list=Database.variable_names
		DATATYPE.SWITCH:
			list=Database.switch_names
	text = list[index+1]
	
func _update(type):
	var name_list
	match type:
		"Variable":
			datatype = DATATYPE.VAR
			name_list = Database.variable_names
		"Switch": 
			datatype = DATATYPE.SWITCH
			name_list = Database.switch_names
	item_list.clear()
	
	var index = 0
	for i in name_list:
		if index == 0:
			index += 1
			continue
			
		var item_text = name_list[index]
		index += 1
		item_list.add_item(item_text)
	_on_item_list_item_activated(0)

func _on_button_down():
	get_child(0).show()
	self_modulate = Color(0,0,0,0)
