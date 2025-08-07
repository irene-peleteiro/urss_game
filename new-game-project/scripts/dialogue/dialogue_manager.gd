extends Node2D

@onready var dialogue_ui: Control = $Dialogue

var npc: Node = null

func show_dialogue(npc, text=""):
	if text != "":
		dialogue_ui.show_dialogue(npc.npc_name, text)
	else:
		var dialogue = npc.get_current_dialogue()
		# DIALOGUE IS A LIST OF TEXTS !!!
		if dialogue == null:
			return
		dialogue_ui.change_dialogue_colour(npc.dialogue_colour)
		dialogue_ui.change_text_colour(npc.dialogue_text_colour)
		dialogue_ui.show_dialogue(npc.npc_name, dialogue)

func hide_dialogue():
	dialogue_ui.hide_dialogue()
