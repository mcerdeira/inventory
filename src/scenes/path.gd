extends AnimatedSprite
export var index = 0
var idx = 0
var miles_stones = []
var started = false
var end = false
var pause_time = 0

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

func _physics_process(delta):
	if started and !end:
		if !Global.event_window.visible:
			if Global.player_obj.position.x < to_global(miles_stones[idx].position).x:
				Global.player_obj.position.x = lerp(Global.player_obj.position.x, to_global(miles_stones[idx].position).x, 0.1)
				if abs((Global.player_obj.position.x - to_global(miles_stones[idx].position).x)) <= 0.1:
					Global.event_window.set_type(miles_stones[idx].type, miles_stones[idx].anim)
					idx += 1
					if idx > miles_stones.size() - 1:
						end = true

func start_quest():
	for _i in self.get_children():
		if is_instance_valid(_i) and _i.is_in_group("milestone") and _i.inactive == false:
			miles_stones.push_back(_i)
			started = true

func _ready():
	var idx = Global.pick_random([0, 1, 2])
	path = paths[idx]
	var path_config = Global.pick_random(path_configurations[idx])
	
	Global.paths[index] = self
	
	for p in path:
		var node = get_node("MileStone" + str(p))
		node.inactive = true
		node.queue_free()
		
	var ee = 0
	for _i in self.get_children():
		if is_instance_valid(_i) and _i.is_in_group("milestone") and _i.inactive == false:
			_i.set_type(path_config[ee])
			ee += 1
