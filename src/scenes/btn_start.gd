extends Button
var is_pressed = false

func _on_btn_start_pressed():
	if !is_pressed:
		disabled = true
		Global.paths[Global.path].start_quest()
		is_pressed = true
		Global.QUEST_STARTED = true
