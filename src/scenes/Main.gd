extends Node2D
var x_to = 512
var y_to = 224
var ItemSingle = preload("res://scenes/ItemSingle.tscn")
var ItemO = preload("res://scenes/ItemO.tscn")
var ItemI = preload("res://scenes/ItemI.tscn")
var ItemL = preload("res://scenes/ItemL.tscn")

func _ready():
	var _itm = null
	var max_y = 0
	var y_base = 0
	var itm_x = null
	var itm_y = null
	var pos = null
	for item in Global.RUN_ITEMS:
		if itm_x == null:
			itm_x = 288
		
		if item.size == "single":
			_itm = ItemSingle.instance()
			itm_y = y_base + 64
			pos = Vector2(itm_x, itm_y)
			itm_x += 32
			if max_y < 64:
				max_y = 64
			
		if item.size == "O":
			_itm = ItemO.instance()
			itm_y = y_base + 64
			pos = Vector2(itm_x, itm_y)
			itm_x += 64
			if max_y < 64:
				max_y = 64
			
		if item.size == "I":
			_itm = ItemI.instance()
			itm_y = y_base + 128
			pos = Vector2(itm_x, itm_y)
			itm_x += 32
			if max_y < 128:
				max_y = 128
			
		if item.size == "L":
			_itm = ItemL.instance()
			itm_y = y_base + 96
			pos = Vector2(itm_x, itm_y)
			itm_x += 64
			if max_y < 96:
				max_y = 96
			
		if itm_x > x_to:
			itm_x = null
			y_base += max_y
			max_y = 0
			
		_itm.position = pos
		_itm.set_type(item)
		add_child(_itm)
