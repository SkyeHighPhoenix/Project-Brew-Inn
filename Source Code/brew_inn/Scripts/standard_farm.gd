extends "res://Scripts/farm_tile.gd"
const typeResources = {}

# Called when the node enters the scene tree for the first time.
func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	category = "standardFarm"
	finalType = buildingType
	GlobalTick.tickIncreased.connect(tickIncrease)
	Irrigated = irrigationStatus
	tileType = buildingType
	tilePosition = coordinates
	tileSize = size
	tilemapLocations = {"greenhouse":Vector2i(0,2),"orchardLemon":Vector2i(3,4),
	 "berryBushes":Vector2i(0,5), "blueberries":Vector2i(0,10),"strawberries":Vector2i(3,10),
	"blackberries":Vector2i(6,10),"orchardApple":Vector2i(0,11),"orchard":Vector2i(3,11),
	"orchardLime":Vector2i(6,11),"orchardPear":Vector2i(9,11)}
	setTileAt.emit(tilemapLocations[buildingType], tilePosition)
	pass
