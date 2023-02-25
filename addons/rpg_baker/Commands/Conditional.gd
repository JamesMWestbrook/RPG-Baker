extends Command
class_name Conditional

enum DATATYPE {VAR, SWITCH, NONE}
var checked_value_type: DATATYPE
var compared_value_type: DATATYPE

enum COMPARE {IS, IS_NOT, GREATER_THAN,LESS_THAN,GREATER_THAN_OR_EQUAL,LESS_THAN_OR_EQUAL}
var compare: COMPARE

var compare_to_database = true
var compared_value
var is_string = false
