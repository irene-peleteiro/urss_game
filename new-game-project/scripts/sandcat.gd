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
var is_scared = false
var crow_direction 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var artstyle = "1"
@onready var down_collision: CollisionShape2D = $down_collision
@onready var up_collision: CollisionShape2D = $up_collision
@onready var sprint_collision: CollisionPolygon2D = $sprint_collision

# camera
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	Quest.player = self


func _physics_process(delta: float) -> void:
	artstyle = ArtStyle.artstyle
	
	# check if the player wants to interact with NPC
	interact(delta)
	
	# Add the gravity.
	if not is_on_floor() and not is_jumping:
		velocity += get_gravity() * delta * gravity_multiplier
		coyote_timer += delta
	else:
		coyote_timer = 0


	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# manage movement
	if shake_off and shake_off_timer < shake_off_max:
		animated_sprite.play("shake" + artstyle)
		shake_off_timer += delta
		velocity.x = 0
		velocity += get_gravity() * delta * gravity_multiplier
	elif is_interacting:
		shake_off_timer = 0
		shake_off = false
		velocity.x = 0
		velocity += get_gravity() * delta * gravity_multiplier
	elif is_scared:
		shake_off_timer = 0
		shake_off = false
		velocity = crow_direction * 300
		animated_sprite.play("scared" + artstyle)
	else:
		speed = 800
		shake_off_timer = 0
		shake_off = false
		
		jump(delta)
		sprint()
		down()
		if is_down:
			speed = 500
			is_head_wet = false
		
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			
		
		if is_head_wet:
			head_wet(delta)
	
	
	
	# flip sprite
	if direction>0:
		animated_sprite.flip_h = false
	elif direction<0:
		animated_sprite.flip_h = true
	
	# handle animations
	if not is_down and not shake_off and not is_scared: # down/shake have specific animation
		if is_jumping:
			animated_sprite.play("prejump" + artstyle)
		elif not is_on_floor():
			animated_sprite.play("fall" + artstyle)
		elif is_sprinting:
			animated_sprite.play("sprint" + artstyle)
		elif is_interacting:
			animated_sprite.flip_h = should_face_left # ensure talking in right direction
			animated_sprite.play("idle" + artstyle)
		elif direction == 0:
			if is_head_wet:
				animated_sprite.play("idle_wet" + artstyle)
			else:
				animated_sprite.play("idle" + artstyle)
		else:
			if is_head_wet:
				animated_sprite.play("run_wet" + artstyle)
			else:
				animated_sprite.play("run" + artstyle)
	
	move_and_slide()


func jump(delta: float):
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer<coyote_time):
		if is_down:
			is_down = false
			up_collision.disabled = false
			sprint_collision.disabled = true
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

func down():
	if Input.is_action_pressed("down") and not is_down:
		is_down = true
		up_collision.disabled = true
		sprint_collision.disabled = true
		down_collision.disabled = false
		animated_sprite.play("down" + artstyle)

var is_sprinting = false

func sprint():
	if Input.is_action_pressed("sprint") and is_head_wet:
		up_collision.disabled = true
		sprint_collision.disabled = false
		down_collision.disabled = true
		is_sprinting = true
		speed = 1100
	else:
		is_sprinting = false

var is_head_wet = false
var head_wet_timer = 0
var head_wet_max = 5
var shake_off = false
var shake_off_timer = 0
var shake_off_max = 1

func head_wet_signal():
	if not is_down:
		is_head_wet = true

func head_wet(delta: float):
	head_wet_timer += delta
	if head_wet_timer > head_wet_max:
		is_head_wet = false
		head_wet_timer = 0
		shake_off = true
		is_sprinting = false
		up_collision.disabled = false
		sprint_collision.disabled = true
		down_collision.disabled = true


# interacting with characters
var can_interact = false
var interacting_with = null
var should_face_left = false
var is_interacting = false

func interact(delta: float):
	if can_interact:
		camera.zoom = camera.zoom.lerp(Vector2(0.8,0.8), 1 * delta)
	else:
		camera.zoom = camera.zoom.lerp(Vector2(0.5,0.5), 1 * delta)
	if Input.is_action_just_pressed("interact") and is_interacting:
		# if interact is pressed again, go to next dialogue
		interacting_with.next_dialogue()
		interacting_with.start_dialogue() # show (next) dialogue
		if interacting_with.current_index == 0:
			interacting_with.end_dialogue()
			is_interacting = false
	elif Input.is_action_just_pressed("interact") and can_interact:
		# if not interacting yet, start dialogue
		is_interacting = true
		interacting_with.start_dialogue()
