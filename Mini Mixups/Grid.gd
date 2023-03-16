extends TileMap

var tile_size = get_cell_size()

var grid_size = Vector2(16,16)
export (Array, Resource) var grid = []

onready var plantPrefab = preload("res://Plant.tscn")

export (Resource) var dirt

func _on_Player_mouse_pressed():
	if GameManager.itemHeld == null: return
	var cell = self.world_to_map(get_global_mouse_position())
	var tile_center_pos = map_to_world(cell)
	set_space(cell.x, cell.y, tile_center_pos, GameManager.itemHeld)
	
	

func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	get_parent().get_node("Player").connect("mouse_pressed", self, "_on_Player_mouse_pressed")

	

func is_space_clear(x, y):
	if grid[x][y] == null:
		return true
	else:
		return false
		
func set_space(x,y, pos, item):
	if x >= grid_size.x:
		return
	if y >= grid_size.y:
		return
	if item.Placable == null:
		print("sad:)")
		return
	if item.Placable is Plant:
		var cell = grid[x][y]
		cell = item
		var new_node = plantPrefab.instance()
		new_node.resource = item.Placable
		new_node.position = pos
		add_child(new_node)
	if item.Placable is Machine:
		var new_node = item.Placable.prefab.instance()
		if item.Placable.spaces > 1:
			if item.Placable.spaces / 2 < 2: return
			for i in item.Placable.spaces / 2:
				var cell = grid[x + i][y]
				cell = item
				for h in item.Placable.spaces / 2:
					var L_cell = grid[x + i][y + h]
					L_cell = item
		new_node.resource = item.Placable
		new_node.position = pos
		add_child(new_node)
	
	
func remove_space(x,y):
	var cell = grid[x][y]
	cell = null
	set_cell(x,y, -1)
	

