extends Node2D

func _ready():
	add_to_group("item_slots")

func select_event():
	$Slot1.animation = "selected"
	
func unselect_event():
	$Slot1.animation = "default"
	
func invalid_event():
	$Slot1.animation = "invalid"
