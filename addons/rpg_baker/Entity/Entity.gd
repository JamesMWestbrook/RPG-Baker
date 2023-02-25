extends Node

var RunningCommand = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _run_event(commands_to_run):
	for command in commands_to_run:
		command.run()


