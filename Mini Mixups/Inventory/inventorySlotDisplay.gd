extends CenterContainer

onready var textureRect = $TextureRect
var inventory = preload("res://Inventory/Inventory.tres")

enum Type { BAR, BOX, CRAFT }
export(Type) var Slot_Type

func display_item(item):
	if item is Item:
		textureRect.texture = item.texture
	else:
		textureRect.texture = load("res://icon.png")

func _on_CenterContainer_gui_input(event):
	if self.Slot_Type != 0: return;
	if event.is_action_pressed("click"):
		var itemInSlot = inventory.items[get_index()]
		if itemInSlot == null: return
		print(itemInSlot.name)
		GameManager.itemHeld = itemInSlot;

func get_drag_data(_position):
	var item_index = get_index()
	if Slot_Type == 2:
		item_index += 20
	if inventory.items[item_index] == null: return
	var item = inventory.remove_item(item_index)

	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPrev = TextureRect.new()
		dragPrev.texture = item.texture
		
		#var c = Control.new()
		#c.add_child(dragPrev)
		#dragPrev.rect_position = -0.5 * self.rect_size
		dragPrev.rect_position = self.get_global_position()
		set_drag_preview(dragPrev)
		inventory.drag_data = data
		return data
		
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	var my_item_index = get_index()
	if Slot_Type == 2:
		my_item_index += 20
	var my_item = inventory.items[my_item_index]
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount
		inventory.emit_signal("items_changed", [my_item_index])
	else:
		inventory.swap_item(my_item_index, data.item_index)
		inventory.set_items(my_item_index, data.item)
	inventory.drag_data = null
