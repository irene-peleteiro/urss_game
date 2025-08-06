extends Control


func _on_button_pressed() -> void:
	get_tree().paused = true
	$".".visible = false
	$"../art_style_menu".visible = true
