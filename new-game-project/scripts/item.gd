@tool
extends Area2D


@onready var sprite = $Sprite2D

@export var item_id: String
@export var item_quantity: int
@export var item_icon: Texture2D


func _ready() -> void:
	# show in game
	if not Engine.is_editor_hint():
		sprite.texture = item_icon
		
func _process(delta: float) -> void:
	# show in editor
	if Engine.is_editor_hint():
		sprite.texture = item_icon



func _on_body_entered(body: Node2D) -> void:
	if body.name == "sandcat":
		pass

func _on_body_exited(body: Node2D) -> void:
	if body.name == "sandcat":
		pass
