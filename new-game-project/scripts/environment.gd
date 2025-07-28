extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var artsyle = "1"

@onready var cave_background: Polygon2D = $cave_background
@onready var cave_1: Node2D = $cave1
@onready var all_platforms: Node2D = $all_platforms


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cave_background.texture = load("res://assets/style" +artsyle+ "/environment/cave_background.png")
	cave_1.get_node("StaticBody2D/Cave1").texture = load("res://assets/style" +artsyle+ "/environment/cave1.png")
	
	for platform in all_platforms.get_children():
		if "platform" in platform.name:
			platform.get_node("StaticBody2D/Platform").texture = load("res://assets/style" +artsyle+ "/environment/platform.png")
		if "floor" in platform.name:
			platform.get_node("StaticBody2D/Floor").texture = load("res://assets/style" +artsyle+ "/environment/floor.png")

func change_artstyle_1():
	artsyle = "1"
func change_artstyle_2():
	artsyle = "2"
func change_artstyle_3():
	artsyle = "3"
