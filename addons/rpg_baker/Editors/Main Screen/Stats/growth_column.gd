extends Panel


var column_row:int #index to get full list of stats
var StatRow = preload("res://addons/rpg_baker/Editors/Main Screen/Stats/StatRow.tscn")
signal update_stat(column_index,row_index,value)

func _ready():
	$StatName.text = RPG_Stats.stat_names()[column_row]
	for i in 99:
		var stat_row = StatRow.instantiate()
		stat_row.column_row = column_row
		stat_row.row_index = i #+ 1
		stat_row.connect("update_stat",_update_stat)
		#_update_stat
		$ScrollContainer/VBoxContainer.add_child(stat_row)
		
		
func _update_stat(column_index,row_index,value):
	emit_signal("update_stat",column_index,row_index,value)
