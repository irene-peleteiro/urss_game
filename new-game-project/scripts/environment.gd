extends Node2D



var artstyle = "1"

@onready var cave_background: Polygon2D = $cave_background
@onready var cave_1: Node2D = $cave1
@onready var all_platforms: Node2D = $all_platforms


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	artstyle = ArtStyle.artstyle
	
	cave_background.texture = load("res://assets/style" +artstyle+ "/environment/cave_background.png")
	cave_1.get_node("StaticBody2D/Cave1").texture = load("res://assets/style" +artstyle+ "/environment/cave1.png")
	
	for platform in all_platforms.get_children():
		if "platform" in platform.name:
			platform.get_node("StaticBody2D/Platform").texture = load("res://assets/style" +artstyle+ "/environment/platform.png")
		if "floor" in platform.name:
			platform.get_node("StaticBody2D/Floor").texture = load("res://assets/style" +artstyle+ "/environment/floor.png")
