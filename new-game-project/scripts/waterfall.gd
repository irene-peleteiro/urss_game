extends Node2D

@onready var splash: AnimatedSprite2D = $Area2D/splash
@onready var original: Sprite2D = $Area2D/ClipingMask
@onready var water: AnimatedSprite2D = $Area2D/ClipingMask/water

var max_segments = 30
var current_collision = Vector2(0,0)
var max_collision = Vector2(0,0)
var segment_height
var start_point

var reset # only used in the start frames to make sure the splash is correctly drawn
# the new_collision works fro all but the first time its drawn

func _ready():
	start_point = original.global_position
	reset = true
	spawn_waterfall()

func _process(delta: float) -> void:
	
	var new_collision = get_collision_point(start_point, max_collision)

	if new_collision != current_collision or reset:
		reset = false
		clear_old_waterfall()
		original.position = Vector2(0,new_collision.y-max_collision.y-420)
		spawn_waterfall()
		
		splash.global_position = new_collision + Vector2(0,-150)
		current_collision = new_collision
	

func spawn_waterfall():
	segment_height = original.texture.get_height()
	var last_y = original.position.y
	for i in range(max_segments):
		# Create a new segment
		var new_segment = original.duplicate()
		new_segment.position = Vector2(original.position.x, last_y + segment_height/2 -20)
		add_child(new_segment)
		new_segment.add_to_group("water_segments")
		
		last_y = new_segment.position.y
		
		if check_collision(new_segment.global_position, new_segment.global_position + Vector2(0, segment_height)):
			var last = original.duplicate()
			last.position = Vector2(original.position.x, last_y + segment_height/2 -20)
			add_child(last)
			last.add_to_group("water_segments")
			
			current_collision = get_collision_point(new_segment.global_position, new_segment.global_position + Vector2(0, segment_height / 2))
			if current_collision > max_collision:
				max_collision = current_collision
			
			break


func clear_old_waterfall():
	for node in get_tree().get_nodes_in_group("water_segments"):
		node.queue_free()

func check_collision(start: Vector2, target: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsRayQueryParameters2D.create(start, target)
	var result = space_state.intersect_ray(query)
	
	return result.size() > 0

func get_collision_point(start: Vector2, target: Vector2) -> Vector2:
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsRayQueryParameters2D.create(start, target)
	var result = space_state.intersect_ray(query)
	if result.size() > 0:
		if result.collider.name == "sandcat":
			emit_signal("sandcat_head_wet")
		return result.position
	else: 
		return Vector2(0,0)

signal sandcat_head_wet

	
