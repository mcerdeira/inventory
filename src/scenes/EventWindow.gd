extends Node2D
var type = ""
var anim = ""
var pausetime = 2.5
var back = ["woods", "graveyard"]

func _ready():
	visible = false
	Global.event_window = self
	
func _physics_process(delta):
	if visible:
		pausetime -= 1 * delta
		if pausetime <=0:
			pausetime = 2.5
			visible = false

func set_type(_type, _anim):
	var b = Global.pick_random(back)
	if b == "woods":
		$ColorRect2.color = Color8(30, 38, 0, 255)
	else:
		$ColorRect2.color = Color8(38, 0, 0, 255)
	
	$Backgrounds.choose_background(b)
	visible = true
	type = _type
	anim = _anim
	$icon.animation = anim

