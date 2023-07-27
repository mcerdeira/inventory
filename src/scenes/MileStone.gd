extends Node2D
var index = 0

func _ready():
	index = get_parent().index

func _physics_process(delta):
	$back.frame = (Global.path == index)
