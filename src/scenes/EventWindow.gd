extends Node2D
var type = ""
var anim = ""

func _ready():
	Global.event_window = self


func set_type(_type, _anim):
	type = _type
	anim = _anim
	$icon.animation = anim
