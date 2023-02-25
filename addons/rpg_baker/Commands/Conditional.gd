extends Command
class_name Conditional

enum DATATYPE {VAR, SWITCH}
@export var checked_value_type: DATATYPE

enum COMPARE {IS, IS_NOT, GREATER_THAN,LESS_THAN,GREATER_THAN_OR_EQUAL,LESS_THAN_OR_EQUAL}
@export var compare: COMPARE

@export var compare_to_database: bool = true
@export var checked_value: String
##If Switch and NOT compared to database use true or false as a string
@export var compared_value: String
@export var compare_strings:bool

@export var true_commands_to_run:Array[Command]
@export var false_commands_to_run:Array[Command]


func run():
	var condition_true 
	match checked_value_type:
		DATATYPE.VAR:
			var value_one = Database.variables[int(checked_value)]
			var value_two
			
			if compare_to_database:
				value_two = Database.variables[int(compared_value)]
			else:
				value_two = compared_value
			
			match compare:
				COMPARE.IS:
					if compare_strings:
						condition_true = value_one == value_two
					else:
						condition_true = float(value_one) == float(value_two)
						
				COMPARE.IS_NOT:
					if compare_strings:
						condition_true = value_one != value_two
					else:
						condition_true = float(value_one) != float(value_two)
				COMPARE.GREATER_THAN:
					condition_true = value_one > value_two
				COMPARE.GREATER_THAN_OR_EQUAL:
					condition_true = value_one >= value_two
				COMPARE.LESS_THAN:
					condition_true = value_one < value_two
				COMPARE.LESS_THAN_OR_EQUAL:
					condition_true = value_one <= value_two
					
		DATATYPE.SWITCH:
			var value_one = Database.switches[int(checked_value)]
			var value_two 
			
			if compare_to_database:
				value_two = Database.switches[int(compared_value)]
			else:
				value_two = compared_value == "true"
			match compare:
				COMPARE.IS:
					condition_true = value_one == value_two
				COMPARE.IS_NOT:
					condition_true = value_one != value_two
			
			
			
	if condition_true:
		for i in true_commands_to_run:
			i.run()
	else:
		for i in false_commands_to_run:
			i.run()


