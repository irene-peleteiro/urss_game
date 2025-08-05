extends Node2D

@onready var area_2d: Area2D = $StaticBody2D/Area2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/Area2D/CollisionShape2D
@onready var breaking_platform: Sprite2D = $StaticBody2D/BreakingPlatform
@onready var smoke: Sprite2D = $StaticBody2D/BreakingPlatform/Smoke

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	smoke.visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "sandcat":
		smoke.visible = true
		if body.is_sprinting:
			break_wall()
	
func break_wall():
	var tween = create_tween()
	
	# Shake up/down a few times
	var original_pos = position
	var shake_time = 0.1
	
	tween.tween_property(self, "position", original_pos + Vector2(50, -1), shake_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_callback(Callable(self, "disable_and_hide"))
	
func disable_and_hide():
	breaking_platform.visible = false
	collision_shape_2d.disabled = true
	smoke.visible = false
	queue_free()
