@tool
extends Area2D


@onready var sprite = $AnimatedSprite2D

@export var item_id: String
@export var item_quantity: int
@export var item_animation: SpriteFrames

var quest_manager: Node2D = null

func _ready() -> void:
	# show in game
	if not Engine.is_editor_hint():
		sprite.sprite_frames = item_animation
		quest_manager = Quest.player.quest_manager

func _process(delta: float) -> void:
	# show in editor
	if Engine.is_editor_hint():
		sprite.sprite_frames = item_animation


func _on_body_entered(body: Node2D) -> void:
	if body.name == "sandcat":
		# play pick_up animation
		Quest.add_to_inventory(item_id, item_quantity)
		for quest in quest_manager.active_collect_quests():
			quest_manager.complete_collect_obj(item_id, item_quantity)
		queue_free()
