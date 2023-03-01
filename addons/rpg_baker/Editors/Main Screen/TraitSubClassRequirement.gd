@tool
extends Panel

var index = 0
signal required_state_change(main_class,second_class,third_class,fourth_class)

var main_class = false
var second_class = false
var third_class = false
var fourth_class = false
@export var buttons: Array[CheckBox]

@onready var primary_button = $GridContainer/PrimaryButton
@onready var secondary_button = $GridContainer/SecondaryButton
@onready var third_button = $GridContainer/TertiaryButton
@onready var fourth_button = $GridContainer/QuaternaryButton




func _on_primary_button_toggled(button_pressed):
	main_class = button_pressed
	emit_signal("required_state_change",main_class,second_class,third_class,fourth_class)


func _on_secondary_button_toggled(button_pressed):
	second_class = button_pressed
	emit_signal("required_state_change",main_class,second_class,third_class,fourth_class)

func _on_tertiary_button_toggled(button_pressed):
	third_class = button_pressed
	emit_signal("required_state_change",main_class,second_class,third_class,fourth_class)

func _on_quaternary_button_toggled(button_pressed):
	fourth_class = button_pressed
	emit_signal("required_state_change",main_class,second_class,third_class,fourth_class)
