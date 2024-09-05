@tool
extends CharacterBody2D

#adding or removing @export_group("Collision") makes the engine crash so no export grouping for now

@export var collider_vector_scale:Vector2:
	set(value):
		if Engine.is_editor_hint():
			get_child(1).scale = value
			collider_vector_scale = value
	get:
		if Engine.is_editor_hint():
			return get_child(1).scale
		return Vector2()

@export var TouchTrigger = false
@export var InteractTrigger = false
#where commands will be set 
@export var CommandsToRun:Array[Command]
@export var EventPages = {
	"pages" : []
}
@onready var Collision = $CollisionShape2D
signal run_event(commands_to_run)
# Called when the node enters the scene tree for the first time.
func _ready():
	if TouchTrigger:
		pass
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _collision():
	if TouchTrigger:
		run_event.emit(CommandsToRun)
	pass # Replace with function body.
