extends Control

@onready var panel: Panel = $CanvasLayer/Panel

@onready var dialogue_speaker: Label = $CanvasLayer/Panel/dialogue_box/dialogue_speaker
@onready var dialogue_text: Label = $CanvasLayer/Panel/dialogue_box/dialogue_text

func _ready() -> void:
	hide_dialogue()

func show_dialogue(speaker, text):
	panel.visible = true
	
	dialogue_speaker.text = speaker
	dialogue_text.text = text

func next_dialogue():
	pass

func hide_dialogue():
	panel.visible = false
	Quest.player.is_interacting = false
