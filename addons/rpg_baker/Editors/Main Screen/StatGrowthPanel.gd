extends Panel
@export var StatContainer:VBoxContainer

var start_value
var end_value


func _on_lvl_1_valueedit_text_changed(new_text):
	start_value = int(new_text)

func _on_lvl_99_valueedit_text_changed(new_text):
	end_value = int(new_text)

func _on_button_button_down():
	for i in StatContainer.get_children():
		i.queue_free()
	var growth_set = StatCurve._curve(start_value,end_value,99)
	for i in growth_set:
		pass
		var line = Label.new()
		line.text = str(i)
		StatContainer.add_child(line)
