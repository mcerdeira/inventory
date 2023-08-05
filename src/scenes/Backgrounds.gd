extends Node2D


func choose_background(back):
	$Scene1.visible = false
	$Scene2.visible = false
	if back == "woods":
		$Scene1.visible = true
	else:
		$Scene2.visible = true
