extends Command
class_name TestCommand

enum VALUE_TYPE { VAR,SWITCH, NONE}
var checked_value: VALUE_TYPE

var compared_global = true #if false, means put in custom value
var compared_value
var is_string = false #only applicable if putting in custom var value

