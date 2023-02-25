extends Command
class_name  ChangeSwitch


@export var index:int
@export var value:bool

func run():
	Database.switches[index] = value

