extends CenterContainer

export (Resource) var craft
var inventory = preload("res://Inventory/Inventory.tres")

func _ready():
	$TextureRect.texture = craft.texture
	$RichTextLabel.text = craft.name



func _on_CenterContainer_mouse_entered():
	var needed = get_parent().get_node("words")
	var words = ""
	for i in craft.recipe.size():
		words + " " + craft.recipe[i] + "/n"
	needed.text = words
	


func _on_CenterContainer_mouse_exited():
	var needed = get_parent().get_node("words")
	needed.text = ""


func _on_CenterContainer_gui_input(event):
	if event.is_action_pressed("click"):
		if meet_needs() == true:
			take_away_items()
			inventory.add_item(craft)
			

func take_away_items():
	for i in craft.recipe.size():
		var check = inventory.find(craft.recipe[i])
		inventory.remove_item(check)

func meet_needs():
	for i in craft.recipe.size():
		var check = inventory.find(craft.recipe[i])
		if check == null:
			return false
		var item = inventory.items[check]
		if item.amount < craft.recip[i].amount:
			return false
		else: 
			return true
