extends Panel

enum Scope{RPG_Actor, RPG_Class}
@export var scope:Scope
var class_index
var current_index:int #used for actors OR classes depending on context
var StatColumn = preload("res://addons/rpg_baker/Editors/Main Screen/Stats/StatColumn.tscn")
var test_stats:RPG_Stats = RPG_Stats.new(false)
@onready var ColumnContainer = $ScrollContainer/ColumnContainer


func _ready():
	#_create_columns()
	pass
	
func _create_columns():
	for i in ColumnContainer.get_children():
		i.queue_free()
	var index = 0
	#for i in test_stats.growth:
	for i in 1:
		var new_column = StatColumn.instantiate()
		new_column.column_row = index
		new_column.class_index = class_index
		new_column.connect("update_stat",_update_stat)
		new_column.connect("get_stats_list",_get_stat_list)
		ColumnContainer.add_child(new_column)
		_get_stat_list(i)
		index += 1
	var my_label= Label.new()
	my_label.text = "Kill Meh"
	ColumnContainer.add_child(my_label)
	
func _update_stat(column_index,row_index,value):
	pass
	#CHECK if Actor or Class
	#for now it just affects test_stats
	var stats
	match scope:
		Scope.RPG_Actor:
			var actor = Database.default_actors[current_index]
			stats = Database.default_actors[current_index].stats
		Scope.RPG_Class:
			var _class = Database.classes[current_index]
			stats = Database.classes[current_index].stats
			
	print("Before: " + str(test_stats.growth[column_index][row_index]))
#	test_stats.growth[column_index][row_index] = value
	stats.growth[column_index][row_index] = value
	print("After: " +  str(test_stats.growth[column_index][row_index]))
	
func _get_stat_list(index):
	pass
	var stats
	match scope:
		Scope.RPG_Actor:
			var actor = Database.default_actors[current_index]
			stats = Database.default_actors[current_index].stats
		Scope.RPG_Class:
			var _class = Database.classes[current_index]
			stats = Database.classes[current_index].stats
	ColumnContainer.get_child(index)._set_stat_list(stats.growth[index])
