extends Node2D

@onready var splash: AnimatedSprite2D = $Area2D/splash
@onready var original: AnimatedSprite2D = $Area2D/water
@onready var ray: RayCast2D = $Area2D/RayCast2D

var max_segments = 30
var current_collision = Vector2(0,0)
var max_collision = Vector2(0,0)
var segment_height
var segment_width

func _ready():
	spawn_waterfall()

func _process(delta: float) -> void:
	var new_collision = get_collision_point(original.global_position, max_collision)

	if new_collision != current_collision:
		clear_old_waterfall()
		spawn_waterfall()
		current_collision = new_collision
	

func spawn_waterfall():
	segment_height = original.sprite_frames.get_frame_texture("default",0).get_height()
	segment_width = original.sprite_frames.get_frame_texture("default",0).get_width()
	var last_y = original.position.y
	for i in range(max_segments):
		# Create a new segment
		var new_segment = original.duplicate()
		new_segment.position = Vector2(original.position.x, last_y + segment_height/2 -10)
		add_child(new_segment)
		new_segment.add_to_group("water_segments")
		
		last_y = new_segment.position.y
		
		if check_collision(new_segment.global_position, new_segment.global_position + Vector2(0, segment_height)):
			var last = original.duplicate()
			last.position = Vector2(original.position.x, last_y + segment_height/2 -10)
			
			# Duplicate the material so it's unique
			last.material = last.material.duplicate()
			var shader_mat = last.material
			shader_mat.set_shader_parameter("global_cutoff_y", current_collision.y)
			shader_mat.set_shader_parameter("sprite_global_y", last.global_position.y)
			print(current_collision.y)
			print(last.global_position.y)
			add_child(last)
			last.add_to_group("water_segments")
			
			current_collision = get_collision_point(new_segment.global_position, new_segment.global_position + Vector2(0, segment_height / 2))
			if current_collision > max_collision:
				max_collision = current_collision
			splash.global_position = current_collision + Vector2(0, -150)
			
			
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
	return result.position
