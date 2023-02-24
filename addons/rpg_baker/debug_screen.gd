extends Control



func _debug_variables():
	var new_text = ""
	var index = 0
	var start_point = 1 + Database.values_per_column
	for i in Database.variables:
		if index == 0:
			index += 1
			continue
		new_text += str(index) + ": "
		new_text += Database.variable_names[index]+ ": "
		new_text += Database.variables[index] + ", "
		
		if fmod(float(index), Database.values_per_column) == 0:
			new_text += "\n"
		index += 1
	$variables.text = new_text
