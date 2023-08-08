extends Node2D

func _physics_process(delta):
	$life.visible = false
	$life2.visible = false
	$life3.visible = false
	$mana.visible = false
	$mana2.visible = false
	$mana3.visible = false
	
	if Global.HP > 0:
		$life.visible = true
	if Global.HP > 1:
		$life2.visible = true
	if Global.HP > 2:
		$life3.visible = true
		
	if Global.MP > 0:
		$mana.visible = true
	if Global.MP > 1:
		$mana2.visible = true
	if Global.MP > 2:
		$mana3.visible = true
