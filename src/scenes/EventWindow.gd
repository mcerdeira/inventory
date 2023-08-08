extends Node2D
var type = ""
var anim = ""
var pausetime = 1.5
var back = ["woods", "graveyard"]
var turn_list = []
var enemy_obj = null

func _ready():
	visible = false
	Global.event_window = self
	
func _physics_process(delta):
	if visible:
		pausetime -= 1 * delta
		if pausetime <= 0:
			do_action()
			
func do_action():
	var turn = turn_list.pop_front()
	if turn:
		do_turn(turn)
		pausetime = 0.5
	else:
		visible = false
			
func do_turn(turn):
	if turn == "coins":
		Global.COINS += 1
	elif turn == "heal":
		Global.HP = Global.HP_TOTAL
		Global.MP = Global.MP_TOTAL
	elif turn == "attack":
		enemy_obj.hp -= 1
		if enemy_obj.hp <= 0:
			turn_list = []
	elif turn == "hurt":
		var dmg = enemy_obj.dmg
		Global.HP -= enemy_obj.dmg
		if Global.HP <= 0:
			turn_list = []
			
func get_action():
	turn_list = []
	if type.type == "reward":
		turn_list.append("coins")
	if type.type == "restauration":
		turn_list.append("heal")
	if type.type == "enemy":
		turn_list.append(basic_attack())
	if type.type == "boss":
		turn_list.append(basic_attack())
		
func basic_attack():
	for i in range(9999):
		var action = ""
		if i % 2 == 0:
			turn_list.append("attack")
		else:
			turn_list.append("hurt")
			
func set_type(_type, _anim):
	var b = Global.pick_random(back)
	if b == "woods":
		$ColorRect2.color = Color8(30, 38, 0, 255)
	else:
		$ColorRect2.color = Color8(38, 0, 0, 255)
	
	$Backgrounds.choose_background(b)
	pausetime = 1.5
	visible = true
	type = _type
	anim = _anim
	enemy_obj = type
	$icon.animation = anim
	get_action()

