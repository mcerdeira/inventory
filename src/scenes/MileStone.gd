extends Node2D
var index = 0
var inactive = false
var type = null
var anim = ""

func _ready():
	add_to_group("milestone")
	index = get_parent().index
	
func set_type(_type):
	type = _type.duplicate(true)
	if typeof(type.resource) == TYPE_ARRAY:
		var an = Global.pick_random(type.resource)
		$icon.animation = an
		type.name = type.name + "(" + an + ")"
		
	else:
		$icon.animation = type.resource
		
	anim = $icon.animation

func _physics_process(delta):
	$back.frame = (Global.path == index)

func show_item_data():
	Global.ItemDataManager.receive_data_milestone(type)

func _on_area_input_event(viewport, event, shape_idx):
	if Global.dragging_obj == null and event is InputEventMouseMotion:
		show_item_data()
