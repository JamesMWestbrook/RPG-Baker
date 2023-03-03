extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var debug = false
var sprites: Array[AnimatedSprite2D]
func _ready():
	_setup_actor_sprites()
	_assign_actor_sprite_sets()
	
	
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
	var moving = false
	if Input.is_action_pressed("ui_left"):
		_set_sprite_anim("left")
		moving = true
	if Input.is_action_pressed("ui_right"):
		_set_sprite_anim("right")
		moving = true
		
	if Input.is_action_pressed("ui_up"):
		_set_sprite_anim("up")		
		moving = true
		
	elif Input.is_action_pressed("ui_down"):
		_set_sprite_anim("down")		
		moving = true
	if moving:
		for i in sprites:
			if i.sprite_frames:
				i.play()
	else:
		for i in sprites:
			if i.sprite_frames:
				i.stop()
	
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y,0, SPEED)


	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().has_method("_collision")):
			collision.get_collider()._collision()


func _setup_actor_sprites():
	for i in Database.max_sprite_layers:
		var new_sprite = AnimatedSprite2D.new()
		add_child(new_sprite)
		sprites.append(new_sprite)
		new_sprite.scale *= Database.sprite_scale
		new_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST


func _assign_actor_sprite_sets():
	var index = 0
	for i in Database.default_actors[0].sprite:
		if i != null:
			sprites[index].sprite_frames = load(i)
		else:
			sprites[index].sprite_frames = null
		index += 1
	
	pass
func _set_sprite_anim(new_anim):
	for i in sprites:
		if i.sprite_frames:
			i.animation = new_anim
