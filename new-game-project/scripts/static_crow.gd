extends Node2D

@onready var no_zone: Area2D = $RigidBody2D/no_zone
@onready var crow: AnimatedSprite2D = $RigidBody2D/AnimatedSprite2D

func _ready() -> void:
	original_pos = no_zone.position
	start_looping_tween()

func start_looping_tween():
	var tween = create_tween()
	tween.set_loops()  # Loop forever

	tween.tween_property(no_zone, "position", original_pos + Vector2(150, 0), 0.45)
	tween.tween_property(no_zone, "position", original_pos + Vector2(150, 0), 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(no_zone, "position", original_pos, 0.45)
	
	tween.tween_property(no_zone, "position", original_pos + Vector2(-150, 0), 0.45)
	tween.tween_property(no_zone, "position", original_pos + Vector2(-150, 0), 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(no_zone, "position", original_pos, 0.45)


var move_timer = 0
var going_left = false
var original_pos



func _on_no_zone_body_entered(body: Node2D) -> void:
	if body.name == "sandcat":
		# make player do the following:
		# 	walk AWAY from the crow slowly (use velocity)
		# 	play "scared" animation
		
		body.is_scared = true
		body.crow_direction = (body.global_position - crow.global_position).normalized()


func _on_no_zone_body_exited(body: Node2D) -> void:
	if body.name == "sandcat":
		body.is_scared = false
