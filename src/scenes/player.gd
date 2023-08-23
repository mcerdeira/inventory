extends Node2D

func _ready():
	Global.player_obj = self

func _physics_process(delta):
	if Global.GAMEOVER:
		$player.animation = "dead"
		$eyes.animation = "dead"

func show_item_data():
	Global.ItemDataManager.receive_data_milestone(Global.player)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Global.dragging_obj == null and event is InputEventMouseMotion:
		show_item_data()
