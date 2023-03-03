extends Button
@export var slot_index: int
signal assign_class(class_slot,assigned_class)
var slot_names = ["Primary: ","Secondary: ","Tiertary: ","Quandry: "]

func _ready():
	text = slot_names[slot_index]
func _on_button_down():
	$ItemList.clear()
	$ItemList.add_item("None")
	for i in Database.classes:
		$ItemList.add_item(i.name)
	
	$ItemList.show()
	$ItemList.position = global_position
	

#index = class_chosen
func _on_item_list_item_activated(index,loading = false):
	var actual_class_index
	if loading: #loading from a save
		#-1 = NONE
		if index == -1:
			actual_class_index = -1
		#0 = actual class 0
		else:
			actual_class_index = index
		pass
	else: #when it's first assigned, not saved yet
		if index == 0:
			#0 = NONE, put in -1
			emit_signal("assign_class",slot_index,-1)
			actual_class_index = -1
		else:
			#anything else subtract 1 to have actual class
			emit_signal("assign_class",slot_index,index-1)
			actual_class_index = index-1
	if actual_class_index >= 0:
		text = slot_names[slot_index] + Database.classes[actual_class_index].name
	else:
		text = slot_names[slot_index] + "None"
	$ItemList.hide()
	
