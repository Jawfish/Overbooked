extends TileMap

export(PackedScene) var wall_object: PackedScene
export(PackedScene) var desk_object: PackedScene
export(PackedScene) var shelf_object: PackedScene
export(PackedScene) var dropbox_object: PackedScene
export(PackedScene) var conveyor_object: PackedScene

func _ready() -> void:
	spawn_objects()
	
func spawn_objects() -> void:
	# replace tiles with objects
	for tile in get_used_cells():
		var tile_name: String = tile_set.tile_get_name(get_cellv(tile))
		var scene_to_place: PackedScene
		# what to color-code this object if it is a shelf
		var modulate_object: String
		match tile_name:
			"WallTile":
				scene_to_place = wall_object
			"DeskTile":
				scene_to_place = desk_object
			"RedShelfTile":
				scene_to_place = shelf_object
				modulate_object = "Red"
			"OrangeShelfTile":
				scene_to_place = shelf_object
				modulate_object = "Orange"				
			"GreenShelfTile":
				scene_to_place = shelf_object
				modulate_object = "Green"				
			"BlueShelfTile":
				scene_to_place = shelf_object
				modulate_object = "Blue"				
			"DropBoxTile":
				scene_to_place = dropbox_object
			"ConveyorTile":
				scene_to_place = conveyor_object
		if scene_to_place != null:
			var instance = scene_to_place.instance() as Node2D
			# scenes spawn at the top left of a tile's position, so it  needs to be offset
			instance.position = map_to_world(tile) + Vector2(32, 32)
			instance.rotation_degrees = -90.0 if self.is_cell_transposed(tile.x, tile.y) else 0.0
			instance.scale = Vector2(-1.0 if self.is_cell_x_flipped(tile.x, tile.y) else 1.0,
									 -1.0 if self.is_cell_y_flipped(tile.x, tile.y) else 1.0)
			add_child(instance)
			# remove the placeholder tile
			set_cellv(tile, -1)
			# if the scene is a shelf, color-code it accordingly
			if modulate_object:
				(instance as ShelfObject).set_color(modulate_object)
