extends Button
var is_pressed = false

func _on_btn_start_pressed():
	if !is_pressed and Global.dragging_obj == null:
		disabled = true
		Global.paths[Global.path].start_quest()
		is_pressed = true
		Global.QUEST_STARTED = true
