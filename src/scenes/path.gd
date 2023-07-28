extends AnimatedSprite
export var index = 0
var path = null
var paths = [
	[],           #7
	[2, 3, 5, 6], #3
	[2, 4, 6],    #4
]
var path_configurations = [
	[
		[Global.boss, Global.boss, Global.bornfire, Global.boss, Global.treasure, Global.treasure, Global.treasure],
	], #7
	
	[
	[Global.enemy, Global.treasure, Global.boss],
	[Global.enemy, Global.enemy, Global.enemy],
	[Global.enemy, Global.bornfire, Global.boss],
	], #3
	
	[
		[Global.enemy, Global.enemy, Global.treasure, Global.boss],
		[Global.enemy, Global.enemy, Global.bornfire, Global.boss],
		[Global.boss, Global.enemy, Global.enemy, Global.treasure],
		[Global.boss, Global.boss, Global.treasure, Global.treasure],
	], #4
]

func _ready():
	var idx = Global.pick_random([0, 1, 2])
	path = paths[idx]
	var path_config = Global.pick_random(path_configurations[idx])
	
	for p in path:
		var node = get_node("MileStone" + str(p))
		node.inactive = true
		node.queue_free()
		
	var ee = 0
	for _i in self.get_children():
		if is_instance_valid(_i) and _i.is_in_group("milestone") and _i.inactive == false:
			_i.set_type(path_config[ee])
			ee += 1
