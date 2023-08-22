extends Area2D
var occ = false
var item_object = null
var item_current = null

func _physics_process(delta):
	add_to_group("Slots")
	occ = false
	var list = get_overlapping_areas()
	for l in list:
		if l.is_in_group("other_item"):
			item_current = l.get_parent()
			item_object = item_current.item_object
			occ = true
			break

	var slot = get_parent().get_node("Slot1")
	if occ:
		slot.animation = "occuppied"
	else:
		slot.animation = "default"

func _on_area_area_entered(area):
	pass

func _on_area_area_exited(area):
	pass
