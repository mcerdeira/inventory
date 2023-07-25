extends Node2D
export var sprite : Texture
var original_pos = null
var in_inventory = false
var in_invalid = false

func _ready():
	original_pos = position
	$Sprite.texture = sprite
	
func _physics_process(delta):
	if Global.dragging_obj == self:
		var list = $Area2D.get_overlapping_areas()
		var pre_in_invalid = in_invalid
		in_inventory = false
		in_invalid = false
		for l in list:
			if l.is_in_group("inventory"):
				in_inventory = true
				
			if is_in_invalid_area_drop(l):
				in_invalid = true
	
		if in_inventory and in_invalid:
			for _i in self.get_children():
					if _i.is_in_group("item_slots"):
						_i.invalid_event()
						
		if !in_inventory or (in_inventory and !in_invalid and pre_in_invalid):
			for _i in self.get_children():
					if _i.is_in_group("item_slots"):
						_i.select_event()
	
func _unhandled_input(event):
	if Global.dragging_obj == self and event is InputEventMouseMotion:
		position = event.position
	
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			if Global.dragging_obj == null:
				for _i in self.get_children():
					if _i.is_in_group("item_slots"):
						_i.select_event()
				Global.dragging_obj = self
			elif Global.dragging_obj == self:
				if !in_inventory:
					Global.dragging_obj = null
					position = original_pos
					rotation_degrees = 0
					for _i in self.get_children():
						if _i.is_in_group("item_slots"):
							_i.unselect_event()
				elif in_inventory and in_invalid:
					pass
				else:
					Global.dragging_obj = null
					for _i in self.get_children():
						if _i.is_in_group("item_slots"):
							_i.unselect_event()
					
				
		elif Global.dragging_obj == self and event.button_index == BUTTON_RIGHT:
			rotation_degrees += 90
			
func is_in_invalid_area_drop(area):
	return (area.is_in_group("outsiders") or area.is_in_group("other_item"))

func _on_Area2D_area_entered(area):
	pass

func _on_Area2D_area_exited(area):
	pass
