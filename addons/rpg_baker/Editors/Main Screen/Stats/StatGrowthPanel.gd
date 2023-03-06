extends Panel
var first_level_value
var last_level_value
signal set_stat_list(list,rebuild)
func _on_close_button_down():
	hide()


func _on_generate_sat_growth_button_down():
	var new_stats = StatCurve._curve(first_level_value,last_level_value,99)
	emit_signal("set_stat_list",new_stats,true)
	hide()

func _on_lvl_1_edit_text_changed(new_text):
	first_level_value = int(new_text)


func _on_lvl_99_edit_text_changed(new_text):
	last_level_value = int(new_text)

func _on_curve_menu_button_down():
	show()
	position = get_parent().global_position
