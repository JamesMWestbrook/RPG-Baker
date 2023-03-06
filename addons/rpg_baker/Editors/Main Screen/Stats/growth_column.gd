extends Panel

var class_index
var column_row:int #index to get full list of stats
var StatRow = preload("res://addons/rpg_baker/Editors/Main Screen/Stats/StatRow.tscn")
var stat_list = []
signal update_stat(column_index,row_index,value)
signal get_stats_list(index)

func _ready():
	$StatName.text = RPG_Stats.stat_names()[column_row]
	emit_signal("get_stats_list",column_row)
	_spawn_rows()
		
		
func _update_stat(column_index,row_index,value):
	emit_signal("update_stat",column_index,row_index,value)

func _spawn_rows(save_to_stats = false):
	print( str(column_row) + " Spawn Rows")
#	for i in $ScrollContainer/VBoxContainer.get_children():
	#	i.queue_free()
	#await get_tree().create_timer(1).timeout
	for i in 5:
		var stat_row = StatRow.instantiate()
		stat_row.column_row = column_row
		stat_row.row_index = i 
		stat_row.class_index = class_index
		if !stat_list.is_empty():
			var test = str(stat_list[i])
			print("Row " + str(i) + " " + str(stat_list[i]))
			stat_row.get_node("LineEdit").text = str(stat_list[i])
		else:
			pass
		stat_row.connect("update_stat",_update_stat)
		if save_to_stats:
			stat_row._on_line_edit_text_changed(str(stat_list[i]))
		else:
			pass
			
		#_update_stat
		$ScrollContainer/StatRowContainer.add_child(stat_row)
		
		
func _set_stat_list(list):
	pass
#	stat_list = list
#	if rebuild:
#		_spawn_rows(false)
