extends AnimatedSprite
export var index = 0
var path = null
var paths = [
	[],
	[2, 3, 5, 6],
	[2, 4, 6],
]

func _ready():
	path = Global.pick_random(paths)
	for p in path:
		var node = get_node("MileStone" + str(p))
		node.queue_free()
