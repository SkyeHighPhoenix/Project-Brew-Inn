extends "res://Scripts/farm_tile.gd"

func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	GlobalTick.tickIncreased.connect(tickIncrease)
	Irrigated = irrigationStatus
	tileType = buildingType
	tilePosition = coordinates
	tileSize = size
	tilemapLocations = {"hGL":Vector2i(2,0),"hGR":Vector2i(2,0)}
	setTileAt.emit(tilemapLocations["hGL"], tilePosition)
	setTileAt.emit(tilemapLocations["hGL"], tilePosition-Vector2i(1,0))
	pass

func changeCrop(newCrop, side):
	pass
