extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var debug = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_just_pressed("debug") and OS.has_feature("editor"):
		debug = !debug
		if debug:
			DebugScreen._debug_variables()
		else:
			DebugScreen.get_node("variables").text = ""


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().has_method("_collision")):
			collision.get_collider()._collision()
