extends CharacterBody2D


var speed = 800.0
var jump_velocity = -600.0
var jump_time = 0.25
var coyote_time = 0.075
var gravity_multiplier = 2.00

var is_jumping = false
var jump_timer = 0
var coyote_timer = 0
var prejump_timer = 0

var is_down = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var artstyle = "1"
@onready var down_collision: CollisionShape2D = $down_collision
@onready var up_collision: CollisionShape2D = $up_collision

func change_artstyle_1():
	artstyle = "1"
func change_artstyle_2():
	artstyle = "2"
func change_artstyle_3():
	artstyle = "3"

func _physics_process(delta: float) -> void:
	#print("coyote_timer: ", coyote_timer)
	#print("is_on_floor: ", is_on_floor())
	#print("is_jumping: ", is_jumping)
	# Add the gravity.
	if not is_on_floor() and not is_jumping:
		velocity += get_gravity() * delta * gravity_multiplier
		coyote_timer += delta
	else:
		coyote_timer = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer<coyote_time):
		if is_down:
			is_down = false
			speed = 800
			up_collision.disabled = false
			down_collision.disabled = true
		velocity.y = jump_velocity
		is_jumping = true
	elif Input.is_action_pressed("jump") and is_jumping:
		velocity.y = jump_velocity
	
	if is_jumping and Input.is_action_pressed("jump") and jump_timer<jump_time:
		jump_timer += delta
	else:
		is_jumping = false
		jump_timer = 0

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# flip sprite
	if direction>0:
		animated_sprite.flip_h = false
	elif direction<0:
		animated_sprite.flip_h = true
	
	
	if Input.is_action_pressed("down") and not is_down:
		speed = 500
		is_down = true
		up_collision.disabled = true
		down_collision.disabled = false
		animated_sprite.play("down" + artstyle)
	
	# handle animations
	if not is_down: # down has specific animation
		if is_jumping:
			animated_sprite.play("prejump" + artstyle)
		elif not is_on_floor():
			animated_sprite.play("fall" + artstyle)
		elif direction == 0:
			animated_sprite.play("idle" + artstyle)
		else:
			animated_sprite.play("run" + artstyle)
		

		

	move_and_slide()
	
