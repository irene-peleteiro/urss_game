extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _back_to_game() -> void:
	$"../art_style_button".visible = true
	$".".visible = false
	get_tree().paused = false


func _on_digital_art_pressed() -> void:
	ArtStyle.artstyle = "1"
	_back_to_game() # Go back to level

func _on_pixel_art_pressed() -> void:
	ArtStyle.artstyle = "2"
	_back_to_game() # Go back to level

func _on_pencil_art_pressed() -> void:
	ArtStyle.artstyle = "3"
	_back_to_game() # Go back to level
