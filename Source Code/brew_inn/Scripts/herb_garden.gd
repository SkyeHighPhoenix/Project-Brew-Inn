extends "res://Scripts/farm_tile.gd"

var secondResourceCount = 0

func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	category = "herbGarden"
	finalType = "herbGarden"
	GlobalTick.tickIncreased.connect(tickIncrease)
	Irrigated = irrigationStatus
	tileType = "hGL"
	tilePosition = coordinates
	tileSize = size
	tilemapLocations = {"hGL":Vector2i(0,6),"hGR":Vector2i(1,6),"cinnamonhGR":Vector2i(7,0),"cinnamonhGL":Vector2i(8,0),
	"vanillahGR":Vector2i(7,2),"vanillahGL":Vector2i(8,2),"spearminthGR":Vector2i(8,4),"spearminthGL":Vector2i(8,5),
	"minthGR":Vector2i(14,0),"minthGL":Vector2i(15,0),"nutmeghGR":Vector2i(14,2),"nutmeghGL":Vector2i(15,2)}
	setTileAt.emit(tilemapLocations["minthGR"], tilePosition-Vector2i(1,0))
	setTileAt.emit(tilemapLocations["nutmeghGL"], tilePosition)
	setPlantsGrowing(["cinnamonhGL","vanillahGR"])
	pass

func changeCrop(newCrop:String, side):
	if side == "L":
		setTileAt.emit(tilemapLocations[newCrop+"hGL"], tilePosition-Vector2i(1,0))
		setPlantsGrowing([plantGrowing[0], newCrop])
		storedResources = 0
	else:
		setTileAt.emit(tilemapLocations[newCrop+"hGR"], tilePosition)
		setPlantsGrowing([newCrop, plantGrowing[1]])
		secondResourceCount = 0
	pass

func increaseResources():
	if tick % ticksToGrow == 0 and Irrigated == true:
		storedResources += resourcesOnHarvest
		secondResourceCount += resourcesOnHarvest
		if storedResources > storageCap:
			storedResources = storageCap
		if secondResourceCount > storageCap:
			secondResourceCount = storageCap
	pass

func exportResources(manual = false):
	if tick % workerSpeed == 0 and plantGrowing[0] != null:
		if storedResources > workerExportCount:
			GlobalInventory.addResource(typeToResource[plantGrowing[0]], workerExportCount)
			storedResources -= workerExportCount
		else:
			GlobalInventory.addResource(typeToResource[plantGrowing[0]], storedResources)
			storedResources = 0
	if tick % workerSpeed == 0 and plantGrowing[1] != null:	
		if secondResourceCount > workerExportCount:
			GlobalInventory.addResource(typeToResource[plantGrowing[1]], workerExportCount)
			secondResourceCount -= workerExportCount
		else:
			GlobalInventory.addResource(typeToResource[plantGrowing[1]], secondResourceCount)
			secondResourceCount = 0
	if manual:
		GlobalInventory.addResource(typeToResource[plantGrowing[0]], storedResources)
		GlobalInventory.addResource(typeToResource[plantGrowing[1]], secondResourceCount)
		secondResourceCount = 0
		storedResources = 0
