extends Node2D


func set_life(life):
	$life1.visible = false
	$life2.visible = false
	$life3.visible = false
	$life4.visible = false
	$life5.visible = false
	
	life = ceil(life)
		
	if life == 1:
		$life1.visible = true
	if life == 2:
		$life1.visible = true
		$life2.visible = true
	if life == 3:
		$life1.visible = true
		$life2.visible = true
		$life3.visible = true
	if life == 4:
		$life1.visible = true
		$life2.visible = true
		$life3.visible = true
		$life4.visible = true
	if life == 5:
		$life1.visible = true
		$life2.visible = true
		$life3.visible = true
		$life4.visible = true
		$life5.visible = true
