extends Node2D
var type = ""
var anim = ""
var pausetime = 0.7
var back = ["woods", "graveyard"]
var turn_list = []
var enemy_obj = null
var current_weapon = null

func _ready():
	$player/lbl_health.text = ""
	$lbl_enemy.text = ""
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
		pausetime = 1.5
	else:
		visible = false
			
func do_turn(turn):
	$player/player.material.set_shader_param("line_thickness", 0)
	$icon.material.set_shader_param("line_thickness", 0)
	$player/lbl_health.text = ""
	$lbl_enemy.text = ""
	$player/player.animation = "default"
	$player/eyes.animation = "default"
	$lbl_enemy.add_color_override("font_color", Color8(255, 255, 255, 255))
	$player/lbl_health.add_color_override("font_color", Color8(255, 255, 255, 255))
	
	if turn == "coins":
		var key = get_next_key()
		if key:
			Global.COINS += 10
			$lbl_enemy.text = "+10 GOLD"
			$lbl_enemy.add_color_override("font_color", Color8(255, 255, 0, 255))
		else:
			$lbl_enemy.text = "NOPE"
			
	elif turn == "heal":
		Global.HP = Global.HP_TOTAL
		Global.MP = Global.MP_TOTAL
		$player/lbl_health.text = "REST!"
	elif turn == "attack":
		var attk = get_next_weapon()
		enemy_obj.hp -= attk
		$icon/Life.set_life(enemy_obj.hp)
		$lbl_enemy.text = "-" + str(attk) + " HP"
		$lbl_enemy.add_color_override("font_color", Color8(255, 0, 0, 255))
		$player/player.material.set_shader_param("line_thickness", 1)
		if enemy_obj.hp <= 0:
			turn_list = []
	elif turn == "hurt":
		var dmg = enemy_obj.dmg
		Global.HP -= dmg
		$player/lbl_health.text = "-" + str(dmg) + " HP"
		$player/lbl_health.add_color_override("font_color", Color8(255, 0, 0, 255))
		$player/player.animation = "hurt"
		$player/eyes.animation = "hurt"
		$icon.material.set_shader_param("line_thickness", 1)
		yield(get_tree().create_timer(1), "timeout")
		if Global.HP <= 0:
			var heal = get_next_heal_item()
			if !heal:
				turn_list = []
				Global.GAMEOVER = true
				$player/player.animation = "dead"
				$player/eyes.animation = "dead"
			else:
				$player/lbl_health.text = "+" + str(heal.value) + " HP"
				$player/lbl_health.add_color_override("font_color", Color8(0, 255, 0, 255))
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
	
func get_next_key():
	var key = search_item_by_type("key")
	if key:
		$player/weapon.texture = load(key.resource)
		
	return key
	
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
				$player/lbl_health.text = "+" + str(mheal.value) + " MP"
				$player/item.texture = load(mheal.resource)
				Global.MP = min(mheal.value, Global.MP_TOTAL)
			else:
				current_weapon = null
	
	if current_weapon == null:
		current_weapon = get_next_weapon_item()
		if current_weapon != null:
			$player/weapon.texture = load(current_weapon.resource)

	if current_weapon:
		if current_weapon.type == "magic":
			Global.MP -= 1
			
		var attk = current_weapon.value
		return attk
	else:
		return 0.5
	
func get_action():
	turn_list = []
	if type.type == "reward":
		turn_list.append("coins")
	if type.type == "restauration":
		turn_list.append("heal")
	if type.type == "enemy":
		$icon/Life.visible = true
		$icon/Life.set_life(enemy_obj.hp)
		turn_list.append(basic_attack())
	if type.type == "boss":
		$icon/Life.visible = true
		$icon/Life.set_life(enemy_obj.hp)
		turn_list.append(basic_attack())
		
func basic_attack():
	for i in range(9999):
		var action = ""
		if i % 2 == 0:
			turn_list.append("attack")
		else:
			turn_list.append("hurt")
			
func set_type(_type, _anim):
	$icon/Life.visible = false
	$lbl_enemy.add_color_override("font_color", Color8(255, 255, 255, 255))
	$player/lbl_health.add_color_override("font_color", Color8(255, 255, 255, 255))
	$player/lbl_health.text = ""
	$lbl_enemy.text = ""
	$player/item.texture = null
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
	else:
		$player/weapon.texture = null
		
	$Backgrounds.choose_background(b)
	pausetime = 1.5
	visible = true
	type = _type
	anim = _anim
	enemy_obj = type
	$icon.animation = anim
	get_action()

