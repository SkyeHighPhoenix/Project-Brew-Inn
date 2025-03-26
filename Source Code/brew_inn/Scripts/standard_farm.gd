extends "res://Scripts/farm_tile.gd"


# Called when the node enters the scene tree for the first time.
func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	Irrigated = irrigationStatus
	tileType = buildingType
	tilePosition = coordinates
	tileSize = size
	tilemapLocations = {"greenhouse":Vector2i(0,2),"orchardLemon":Vector2i(3,4), "berryBushes":Vector2i(0,5)}
	setTileAt.emit(tilemapLocations[buildingType], tilePosition)
	pass
