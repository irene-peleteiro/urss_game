extends Control


@onready var art_style_button: Control = $CanvasLayer/ArtStyleButton
@onready var art_style_menu: Control = $CanvasLayer/ArtStyleMenu
var is_menu_opened = false

func _ready() -> void:
	art_style_button.visible = true
	art_style_menu.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		if is_menu_opened == false:
			is_menu_opened = true
			pause_game()
		else:
			is_menu_opened = false
			back_to_game()

func pause_game():
	get_tree().paused = true
	art_style_button.visible = false
	art_style_menu.visible = true

func back_to_game() -> void:
	art_style_button.visible = true
	art_style_menu.visible = false
	get_tree().paused = false

func _on_button_pressed() -> void:
	pause_game()

func _on_digital_art_pressed() -> void:
	ArtStyle.artstyle = "1"
	back_to_game() # Go back to level

func _on_pixel_art_pressed() -> void:
	ArtStyle.artstyle = "2"
	back_to_game() # Go back to level

func _on_pencil_art_pressed() -> void:
	ArtStyle.artstyle = "3"
	back_to_game() # Go back to level
