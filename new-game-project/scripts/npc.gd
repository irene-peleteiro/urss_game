@tool
extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var talking_area = $talking_area

@export var npc_name: String
@export var npc_animation: SpriteFrames
@export var area_offset: int
@export var facing_left: bool


# Dialogue system
@export var dialogue_resource: Dialogue
var npc_dialogue
var current_dialogue = "1.0" # accessed by npc_name + current_dialogue
# .0 are the base dialogues, .5 are the extra info
# progress to 2., 3., etc by progressing with the quests
var current_index = 0

@onready var dialogue_manager: Node2D = $DialogueManager


func _ready() -> void:
	# show in game
	if not Engine.is_editor_hint():
		talking_area.position.x = area_offset
		sprite.sprite_frames = npc_animation
	
	# load dialogue data
	dialogue_resource.load_from_json("res://Resources/Dialogue/dialogue_data.json")
	# initialise dialogue manager
	dialogue_manager.npc = self

func start_dialogue():
	npc_dialogue = dialogue_resource.get_npc_dialogue(npc_name)
	if npc_dialogue.is_empty():
		return
	dialogue_manager.show_dialogue(self)

func get_current_dialogue():
	for branch in npc_dialogue:
		if branch["branch_id"] == npc_name + current_dialogue:
			if branch["text"].size() > current_index:
				return branch["text"][current_index]
	return null

func next_dialogue():
	# progress to next dialogue, triggered when interacting with NPC
	current_index += 1
	if get_current_dialogue() == null:
		# if the main branch is complete, go to extra
		if current_dialogue[-1] == "0":
			current_dialogue[-1] = "5"
		# either way, reset the index to 0 to restart convo
		current_index = 0

func set_current_dialogue(new_dialogue):
	current_dialogue = new_dialogue

func end_dialogue():
	dialogue_manager.hide_dialogue()

func _process(delta: float) -> void:
	# show in editor
	if Engine.is_editor_hint():
		talking_area.position.x = area_offset
		sprite.sprite_frames = npc_animation


func _on_talking_area_body_entered(body: Node2D) -> void:
	if body.name == "sandcat":
		body.can_interact = true
		body.interacting_with = self
		body.should_face_left = facing_left
		print("Sandcat in area")

func _on_talking_area_body_exited(body: Node2D) -> void:
	if body.name == "sandcat":
		body.can_interact = false
