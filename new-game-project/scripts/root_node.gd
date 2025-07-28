extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var menu = $CanvasLayer/art_style_menu
	menu.change_to_digital_art.connect($sandcat.change_artstyle_1)
	menu.change_to_pixel_art.connect($sandcat.change_artstyle_2)
	menu.change_to_digital_art.connect($environment.change_artstyle_1)
	menu.change_to_pixel_art.connect($environment.change_artstyle_2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
