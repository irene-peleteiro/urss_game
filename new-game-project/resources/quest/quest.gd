extends Resource

class_name QuestResource

@export var quest_id: String
@export var quest_name: String
@export var state: String = "not_started"
@export var objective: Objective = null
@export var rewards: Reward = null


func is_completed() -> bool:
	if not objective.is_completed:
		return false
	return true

func complete_collect_obj(item_id: String, quantity: int):
	if objective.target_type == "collect" and objective.target_id == item_id:
		objective.collected_quantity += quantity
		if objective.collected_quantity >= objective.required_quantity:
			objective.is_completed = true
	if is_completed():
		state = "complete"

func complete_talk_obj():
	if objective.target_type == "talk_to":
		objective.is_completed = true
		state = "complete"
