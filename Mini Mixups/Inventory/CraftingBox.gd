extends GridContainer

var inventory = preload('res://Inventory/Inventory.tres')



func _ready():
	inventory.connect("items_changed", self, '_on_items_changed')
	inventory.make_unique()
	update_inventory_display()
	
func update_inventory_display():
	for item_index in range(20,24,1):
		update_inventory_slot_display(item_index)
	
func update_inventory_slot_display(item_index):
	if item_index < 19 or item_index > 24: return
	var inventorySlotDisplay = get_child(item_index - 20)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)
	
func _on_items_changed(indexes):
	for item_index in range(20, 24, 1):
		update_inventory_slot_display(item_index)
