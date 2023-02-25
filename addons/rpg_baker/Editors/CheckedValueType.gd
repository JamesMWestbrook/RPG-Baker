extends Button
signal changed_data_type(type)

func _on_item_list_item_activated(index):
	match index:
		0:
			text = "Variable"
			#$CheckedValue._update(0)
		1:
			text = "Switch"
			#$CheckedValue._update(1)
	self_modulate = Color(1,1,1,1)
	get_child(0).hide()
	emit_signal("changed_data_type",text)

func _on_button_down():
	get_child(0).show()
	self_modulate = Color(0,0,0,0)
	


