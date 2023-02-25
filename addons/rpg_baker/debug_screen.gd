extends Control



func _debug_variables():
	var new_text = ""
	var index = 0
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
	new_text += "\n\n"
	index = 0
	for i in Database.switches:
		if index == 0:
			index += 1
			continue
		new_text += str(index) + ": "
		new_text += Database.switch_names[index]+ ": "
		new_text += str(Database.switches[index]) + ", "
		
		if fmod(float(index), Database.values_per_column) == 0:
			new_text += "\n"
		index += 1
	$variables.text = new_text
