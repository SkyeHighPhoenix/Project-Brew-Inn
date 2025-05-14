extends "res://Scripts/farm_tile.gd"

func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	GlobalTick.tickIncreased.connect(tickIncrease)
	Irrigated = irrigationStatus
	tileType = buildingType
	tilePosition = coordinates
	tileSize = size
	tilemapLocations = {"hGL":Vector2i(0,6),"hGR":Vector2i(1,6),"cinnamonhGR":Vector2i(7,0),"cinnamonhGL":Vector2i(8,0),
	"vanillahGR":Vector2i(7,2),"vanillahGL":Vector2i(8,2),"spearminthGR":Vector2i(8,4),"spearminthGL":Vector2i(8,5),
	"minthGR":Vector2i(14,0),"minthGL":Vector2i(15,0),"nutmeghGR":Vector2i(14,2),"nutmeghGL":Vector2i(15,2)}
	setTileAt.emit(tilemapLocations["hGR"], tilePosition)
	setTileAt.emit(tilemapLocations["hGL"], tilePosition-Vector2i(1,0))
	pass

func changeCrop(newCrop, side):
	pass
