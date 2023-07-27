extends Area2D
var index = 0

func _ready():
	index = get_parent().index

func _physics_process(delta):
	get_parent().frame = (Global.path == index)

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		Global.path = index
		Global.player_obj.position.y = get_parent().position.y
