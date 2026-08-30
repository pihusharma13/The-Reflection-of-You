extends CharacterBody2D
 
@export var player_height := 19.0

@export var walk_speed := 150.0
@export var run_speed := 250.0
@export_range(0, 1) var acceleration := 0.1
@export_range(0, 1) var deceleration := 0.1
 
@export var jump_force := -400.0
@export_range(0, 1) var decelerate_on_jump_release := 0.5

@export var coyote_time := 0.1
 
@export var dash_speed := 1000.0
@export var dash_max_distance := 50.0
@export var dash_curve : Curve
@export var dash_cooldown := 1.0

@export var reflection_y : float = 0.0
 
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shapecast: ShapeCast2D = $ShapeCast2D
 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_jumped := false
var cur_coyote_time := coyote_time

var is_dashing = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

signal dash
signal reflect
 
func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		has_jumped = false
		cur_coyote_time = coyote_time
	else:
		if cur_coyote_time > 0: cur_coyote_time -= delta
		velocity.y -= gravity * delta * up_direction.y
 
	var speed
	if Input.is_action_pressed("run"):
		speed = run_speed
	else:
		speed = walk_speed
 
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		animated_sprite.flip_h = direction == -1
		if is_on_floor():
			if Input.is_action_pressed("run"):
				animated_sprite.play("player_run")
			else:
				animated_sprite.play("player_run")
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
		if is_on_floor():
			animated_sprite.play("player_idle")
 
	# Handle jump.
	if Input.is_action_just_pressed("jump") and cur_coyote_time > 0:
		has_jumped = true
		velocity.y = jump_force * -1 * up_direction.y
		# animated_sprite.play("Jump")
 
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release
 
	# Dash activation
	if Input.is_action_just_pressed("dash") and direction and not is_dashing and dash_timer <= 0:
		dash.emit()
		is_dashing = true
		dash_start_position = position.x
		dash_direction = direction
		dash_timer = dash_cooldown
	
	if Input.is_action_just_pressed("reflect") and is_on_floor():
		reflect.emit()
		flip()
 
	# Performs actual dash
	if is_dashing:
		var current_distance = abs(position.x - dash_start_position)
		if current_distance >= dash_max_distance or is_on_wall():
			is_dashing = false
		else:
			velocity.x = dash_direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance)
			velocity.y = 0
 
	# Reduces the dash timer
	if dash_timer > 0:
		dash_timer -= delta
 
	move_and_slide()

func flip() -> void:
	var trail_particle = $GPUParticles2D
	var img = trail_particle.texture.get_image()
	img.flip_y()
	trail_particle.texture = ImageTexture.create_from_image(img)
	global_position.y = -(global_position.y - reflection_y) + reflection_y
	up_direction.y *= -1
	animated_sprite.flip_v = !animated_sprite.flip_v
	shapecast.force_shapecast_update()
	while shapecast.get_collision_count() > 0:
		position += up_direction * player_height
		shapecast.force_shapecast_update()
