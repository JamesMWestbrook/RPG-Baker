extends Panel

var is_actor = false
var class_index
var column_row #from column row owner
var row_index #individual stat row index
signal update_stat(column_index,row_index,value)


func _ready():
	get_node("rowIndex").text = str(row_index+1)
	$LineEdit.text = str(RPG_Stats._get_stat(class_index,column_row,row_index,is_actor))
	pass


func _on_line_edit_text_changed(new_text):
	emit_signal("update_stat",column_row,row_index,int(new_text))
	
