extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# keep all waterfalls in node and use for loop when needed
	$environment/waterfall.sandcat_head_wet.connect($sandcat.head_wet_signal)
