extends VBoxContainer

func _start():
	_sort()

func _sort():
	var count = get_child_count()
	for i in get_children():
		i.get_child(0).get_child(0).layer = count
		count -= 1
