extends Node2D
var type = ""
var anim = ""
var pausetime = 2.5

func _ready():
	Global.event_window = self
	
func _physics_process(delta):
	if visible:
		pausetime -= 1 * delta
		if pausetime <=0:
			pausetime = 2.5
			visible = false

func set_type(_type, _anim):
	visible = true
	type = _type
	anim = _anim
	$icon.animation = anim

