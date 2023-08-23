extends Node2D

func _ready():
	Global.ItemDataManager = self

func receive_data(item):
	$title.text = "== " + item.name.to_upper() + " =="
	$description.text = item.description + "\n\nEffect: " + item.long_description
	if "uses" in item:
		
		$description.text += "\n\nBattles: " + str(item.uses)

func receive_data_milestone(item):
	$title.text = "== " + item.name.to_upper() + " =="
	$description.text = item.description + "\n\n" + item.long_description
