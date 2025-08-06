extends Resource

class_name Dialogue 

@export var dialogue = {}

func load_from_json(file_path):
	var data = FileAccess.get_file_as_string(file_path)
	var parsed_data = JSON.parse_string(data)
	if parsed_data:
		dialogue = parsed_data
	else:
		print("Error!")
		

# return correct NPC dialogue
func get_npc_dialogue(id):
	if id in dialogue:
		return dialogue[id]["tree"]
	else:
		return []
