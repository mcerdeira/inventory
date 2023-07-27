extends Node
var dragging_obj = null
var HEALTH_ITEMS = []
var WEAPON_ITEMS = []
var RUN_ITEMS = []
var SfxMuted = false
var ItemDataManager = null
var player_obj = null
var path = 0

var apple = {
	"name": "Apple",
	"description": "A regular red apple.",
	"long_description": "Restores 1 HP",
	"type": "health",
	"value" : 1,
	"size": "single",
	"resource": "res://sprites/apple_spr_0.png",
}

var pizza = {
	"name": "Pizza",
	"description": "With extra cheese!",
	"long_description": "Restores 2 HP",
	"type": "health",
	"value" : 2,
	"size": "E",
	"resource": "res://sprites/pizza_spr_0.png"
}

var mana_bottle = {
	"name": "Blue Potion",
	"description": "A bottle with a blue liquid.",
	"long_description": "Restores 1 MP",
	"type": "mana",
	"value" : 1,
	"size": "smallI",
	"resource": "res://sprites/bottle_spr_1.png"
}

var fish = {
	"name": "Fish",
	"description": "A smelly but healthy fish.",
	"long_description": "Restores 2 HP",
	"type": "health",
	"value" : 2,
	"size": "smallI",
	"resource": "res://sprites/fish_spr_0.png"
}

var apple_pie = {
	"name": "Apple pie",
	"description": "A tasty pie made using 4 apples.",
	"long_description": "Restores 4 HP",
	"type": "health",
	"value" : 4,
	"size": "O",
	"resource": "res://sprites/apple_pie_spr_0.png",
}

var key = {
	"name": "Key",
	"description": "A shiny and misterious key.",
	"long_description": "Can open a chest.",
	"type": "special",
	"value" : 0,
	"size": "E",
	"resource": "res://sprites/super_key_spr_0.png"
}

var katana = {
	"name": "Katana",
	"description": "The fiercest weapon from japan.",
	"long_description": "Melee weapon that causes 3 dmg.",
	"type": "melee",
	"value" : 3,
	"size": "I",
	"resource":"res://sprites/katana_spr_0.png"
}

var bat = {
	"name": "Bat",
	"description": "A baseball bat.",
	"long_description": "Melee weapon that causes 1 dmg.",
	"type": "melee",
	"value" : 1,
	"size": "smallI",
	"resource":"res://sprites/bat_spr_0.png"
}

var axe = {
	"name": "Axe",
	"description": "An Axe, made for cutting wood.",
	"long_description": "Melee weapon that causes 2 dmg.",
	"type": "melee",
	"value" : 2,
	"size": "L",
	"resource": "res://sprites/axe_spr_0.png"
}

var shotgun = {
	"name": "Shotgun",
	"description": "A rusty but functional shotgun.",
	"long_description": "Range weapon that causes 2 dmg.",
	"type": "range",
	"value" : 2,
	"size": "I",
	"resource":"res://sprites/gun_spr_0.png"
}

func _ready():
	#Iniciar random
	randomize()
	#Inicializar pools
	HEALTH_ITEMS.push_back(apple)
	HEALTH_ITEMS.push_back(apple_pie)
	HEALTH_ITEMS.push_back(mana_bottle)
	HEALTH_ITEMS.push_back(fish)
	HEALTH_ITEMS.push_back(pizza)
	
	WEAPON_ITEMS.push_back(shotgun)
	WEAPON_ITEMS.push_back(axe)
	WEAPON_ITEMS.push_back(katana)
	WEAPON_ITEMS.push_back(bat)
	WEAPON_ITEMS.push_back(key)
	#Create run
	for i in range(5):
		var h = pick_random(HEALTH_ITEMS)
		var w = pick_random(WEAPON_ITEMS)
		RUN_ITEMS.append(h)
		RUN_ITEMS.append(w)
	
func pick_random(container):
	if typeof(container) == TYPE_DICTIONARY:
		return container.values()[randi() % container.size() ]
	assert( typeof(container) in [
			TYPE_ARRAY, TYPE_COLOR_ARRAY, TYPE_INT_ARRAY,
			TYPE_RAW_ARRAY, TYPE_REAL_ARRAY, TYPE_STRING_ARRAY,
			TYPE_VECTOR2_ARRAY, TYPE_VECTOR3_ARRAY
			], "ERROR: pick_random" )
	return container[randi() % container.size()]

func play_sound(stream: AudioStream, options:= {}) -> AudioStreamPlayer:
	if SfxMuted:
		return null
	else:
		var audio_stream_player = AudioStreamPlayer.new()

		add_child(audio_stream_player)
		audio_stream_player.stream = stream
		audio_stream_player.bus = "SFX"
		
		for prop in options.keys():
			audio_stream_player.set(prop, options[prop])
		
		audio_stream_player.play()
		audio_stream_player.connect("finished", audio_stream_player, "queue_free")
		
		return audio_stream_player
