extends Panel

enum Scope{RPG_Actor, RPG_Class}
@export var scope:Scope

var StatColumn = preload("res://addons/rpg_baker/Editors/Main Screen/Stats/StatColumn.tscn")
var test_stats:RPG_Stats = RPG_Stats.new()
@onready var ColumnList = $ScrollContainer/HBoxContainer


func _ready():
	var index = 0
	for i in test_stats.growth:
		var new_column = StatColumn.instantiate()
		new_column.column_row = index
		new_column.connect("update_stat",_update_stat)
		ColumnList.add_child(new_column)
		index += 1
		
		
func _update_stat(column_index,row_index,value):
	pass
	#CHECK if Actor or Class
	#for now it just affects test_stats
	print("Before: " + str(test_stats.growth[column_index][row_index]))
	test_stats.growth[column_index][row_index] = value
	print("After: " +  str(test_stats.growth[column_index][row_index]))
	
