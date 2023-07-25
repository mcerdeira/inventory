extends Area2D
var occ = false

func _physics_process(delta):
	occ = false
	var list = get_overlapping_areas()
	for l in list:
		if l.is_in_group("other_item"):
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
