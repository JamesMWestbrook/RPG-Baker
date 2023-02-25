extends Button

enum SCOPE{GLOBAL,VALUE}
var scope:SCOPE
var type_ = "Variable"
func _ready():
	_on_item_list_item_activated(0)

func _on_item_list_item_activated(index):
	match index:
		0:
			text = "Global"
			scope = SCOPE.GLOBAL
		1:
			text = "Value"
			scope = SCOPE.VALUE
			
	self_modulate = Color(1,1,1,1)
	$ItemList.hide()
	_update_children()

func _on_button_down():
	get_child(0).show()
	self_modulate = Color(0,0,0,0)
	




func _update(type):
	match type:
		"Variable":
			type_ = "Variable"
		"Switch":
			type_ = "Switch"
	_update_children()
	
	
func _update_children():
	match type_:
		"Variable":
			$CheckBox.hide()
			match scope:
				SCOPE.GLOBAL:
					$ComparedValue.show()
					$LineEdit.hide()
				SCOPE.VALUE:
					$ComparedValue.hide()
					$LineEdit.show()
		"Switch":
			$LineEdit.hide()
			match scope:
				SCOPE.GLOBAL:
					$ComparedValue.show()
					$CheckBox.hide()
				SCOPE.VALUE:
					$ComparedValue.hide()
					$CheckBox.show()
