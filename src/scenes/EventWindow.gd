extends Node2D
var type = ""
var anim = ""
var pausetime = 1.5
var back = ["woods", "graveyard"]
var turn_list = []
var enemy_obj = null
var current_weapon = null

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
		var attk = get_next_weapon()
		enemy_obj.hp -= attk
		if enemy_obj.hp <= 0:
			turn_list = []
	elif turn == "hurt":
		var dmg = enemy_obj.dmg
		Global.HP -= enemy_obj.dmg
		if Global.HP <= 0:
			var heal = get_next_heal_item()
			if !heal:
				turn_list = []
			else:
				$player/item.texture = load(heal.resource)
				Global.HP = min(heal.value, Global.HP_TOTAL)
				
func search_item_by_type(type):
	var slots = get_tree().get_nodes_in_group("Slots")
	for slot in slots:
		if slot and slot.item_current and slot.item_current.visible and slot.item_object.type == type:
			slot.item_current.visible = false
			return slot.item_object
	
	return null
			
func get_next_heal_item():
	return search_item_by_type("health")
	
func get_next_mana_item():
	return search_item_by_type("mana")
	
func get_next_weapon_item():
	var itm = search_item_by_type("magic")
	if !itm:
		itm = search_item_by_type("melee")
		
	return itm
			
func get_next_weapon():
	if current_weapon and current_weapon.type == "magic":
		if Global.MP <= 0:
			var mheal = get_next_mana_item()
			if mheal:
				$player/item.texture = load(mheal.resource)
				Global.MP = min(mheal.value, Global.MP_TOTAL)
			else:
				current_weapon = null
	
	if current_weapon == null:
		current_weapon = get_next_weapon_item()
		$player/weapon.texture = load(current_weapon.resource)

	if current_weapon:
		if current_weapon.type == "magic":
			Global.MP -= 1
			
		var attk = current_weapon.value
		return attk
	else:
		return 0
	
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
	
	if current_weapon != null:
		current_weapon.uses -= 1
		if current_weapon.uses <= 0:
			current_weapon = null
	
	if current_weapon != null:
		$player/weapon.texture = load(current_weapon.resource)
	
	$Backgrounds.choose_background(b)
	pausetime = 1.5
	visible = true
	type = _type
	anim = _anim
	enemy_obj = type
	$icon.animation = anim
	get_action()

