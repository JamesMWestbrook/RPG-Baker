extends Panel

var column_row #from column row owner
var row_index #individual stat row index
signal update_stat(column_index,row_index,value)


func _ready():
	get_node("rowIndex").text = str(row_index+1)


func _on_line_edit_text_changed(new_text):
	emit_signal("update_stat",column_row,row_index,int(new_text))
	
