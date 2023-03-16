extends TextureRect

export (Resource) var resource

var inventory = preload("res://Inventory/Inventory.tres")


func _on_TextureRect_gui_input(event):
	if event.is_action_just_pressed("click"):
		var check = inventory.items.find(resource.input)
		if check == null: return
		inventory.remove_item(inventory.items[check])
		var timer = $Timer
		timer.wait_time = resource.process_time
		timer.start()

func _on_Timer_timeout():
	var new_node = resource.drop_item.instance()
	new_node.position = self.position + self.texture.get_size().x + 16
