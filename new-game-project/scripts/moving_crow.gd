extends Path2D

@onready var no_zone: Area2D = $PathFollow2D/StaticBody2D/no_zone
@onready var crow: AnimatedSprite2D = $PathFollow2D/StaticBody2D/AnimatedSprite2D


func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


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
