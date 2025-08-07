extends Resource

class_name Objective

@export var id: String
@export var description: String
# objective type
@export var target_id: String
@export var target_type: String
# talk_to objective - eg: Mellow2.0 to start next dialogue branch
@export var target_dialogue: String = "" 
# collection objective
@export var required_quantity: int = 0
@export var collected_quantity: int = 0
# objective state
@export var is_completed: bool = false
# next dialogue for NPC to progress to
@export var next_dialogue: String
