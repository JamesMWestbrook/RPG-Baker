extends Command
class_name ChangeVariable

@export var index:int
@export var value:String

func run():
	Database.variables[index] = value
