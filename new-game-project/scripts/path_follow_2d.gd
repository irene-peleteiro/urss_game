extends PathFollow2D

@export var speed: float = 300
var previous_offset: float = 0.0
var flipped: bool = false
@onready var crow: AnimatedSprite2D = $StaticBody2D/AnimatedSprite2D
var flipped_already

func _ready():
	flipped_already = false
	previous_offset = progress

func _process(delta):
	progress += speed * delta

	# Detect loop
	if progress_ratio > 0.5 and not flipped_already:
		flipped_already = true
		flip_sprite()
	if progress_ratio < 0.5 and flipped_already:
		flipped_already = false
		flip_sprite()

	previous_offset = progress

func flip_sprite():
	flipped = !flipped
	crow.flip_h = flipped
