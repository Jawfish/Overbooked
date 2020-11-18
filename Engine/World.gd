extends TileMap

export (PackedScene) var desk_object: PackedScene
export (PackedScene) var shelf_object: PackedScene
export (PackedScene) var dropbox_object: PackedScene
export (PackedScene) var conveyor_object: PackedScene
export (PackedScene) var scanner_object: PackedScene


func _ready() -> void:
	spawn_objects()


func spawn_objects() -> void:
	# replace tiles with objects
	for tile in get_used_cells():
		var tile_name: String = tile_set.tile_get_name(get_cellv(tile))
		var instance: Node2D
		# what to color-code this object if it is a shelf
		match tile_name:
			"DeskTile":
				instance = desk_object.instance()
			"RedShelfTile":
				instance = shelf_object.instance()
				(instance as ShelfObject).color_shelf("Red")
			"OrangeShelfTile":
				instance = shelf_object.instance()
				(instance as ShelfObject).color_shelf("Orange")
			"GreenShelfTile":
				instance = shelf_object.instance()
				(instance as ShelfObject).color_shelf("Green")
			"BlueShelfTile":
				instance = shelf_object.instance()
				(instance as ShelfObject).color_shelf("Blue")
			"DropBoxTile":
				instance = dropbox_object.instance()
				instance.map = self
			"ConveyorTile":
				instance = conveyor_object.instance()
			"ScannerTile":
				instance = scanner_object.instance()
		if instance != null:
			# scenes spawn at the top left of a tile's position, so it  needs to be offset
			instance.position = map_to_world(tile) + Vector2(32, 32)
			instance.rotation_degrees = -90.0 if self.is_cell_transposed(tile.x, tile.y) else 0.0
			instance.scale = Vector2(
				-1.0 if self.is_cell_x_flipped(tile.x, tile.y) else 1.0,
				-1.0 if self.is_cell_y_flipped(tile.x, tile.y) else 1.0
			)
			add_child(instance)
			# remove the placeholder tile
			set_cellv(tile, -1)
			# if the scene is a shelf, color-code it accordingly
