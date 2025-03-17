extends Node2D
# when tile is deleted you must remove all instances of this tile 
# from connected tiles and storage


var tilePosition = Vector2i() # liles main tile position
var tileSize = Vector2i() # 0,0 is a 1 by 1
var tileType = ""
var plantGrowing = ""
var Irrigated = false
var storageBox = null
var growthStage = 0
var connections = []

# variables from will 
var tick = 0
var ticksToGrow = 100
var resourcesOnHarvest = 25
var localStorage = true
var storageCap = 500
var storedResources = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTick.tickIncrease.connect(tickIncrease)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
func increaseResources():
	if tick % ticksToGrow == 0:
		if localStorage == true:
			storedResources += resourcesOnHarvest
			if storedResources > storageCap:
				storedResources = storageCap
			print(storedResources)
		else:
			storageBox.addResources(resourcesOnHarvest)

func createBuilding(buildingType:String, coordinates:Vector2i, tileSize:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	Irrigated = irrigationStatus
	tileType = buildingType
	tilePosition = coordinates
	match tileType:
		"cropPlot":
			checkForStorage(connectedTiles)
			localStorage = false
	pass

func tickIncrease():
	tick += 1
	increaseResources()

func checkOutputs(coordsIn):
	# take block
	# check if it matches an input or output on my one
	# add to inputs and outputs respectively
	pass
	
func checkForStorage(tiles): 
	# checks for any available storage boxes to connect to when a crop plot
	var currentPriority = null
	var currentPriorityType = null
	for i in tiles:
		var discoveredTileType = i.tileType
		var discoveredStorage = null
		match discoveredTileType:
			"cropPlot":
				if i not in connections:
					connections.append(i)
					i.addConnection(self)
				if i.storageBox != null and i.storageBox.getAvailable() > 0:
					discoveredStorage = i.storageBox
		match currentPriorityType:
			null:
				currentPriority = discoveredStorage
				currentPriorityType = discoveredTileType
			"cropPlot":
				if discoveredTileType == "storage":
					currentPriority = discoveredStorage
					currentPriorityType = discoveredTileType
	storageBox = currentPriority
				
	pass

func addConnection(toConnect):
	connections.append(toConnect)
	pass

func setStorage(settingStorage, checkedTiles = []):
	# messy tree traversal alghorythm, idrc so long as it works
	for i in connections:
		if i.storageBox == null and settingStorage.getAvailable > 0:
			settingStorage.addNode(i.tilePosition)
			i.storageBox = settingStorage
	for i in connections:
		if i.storageBox == settingStorage and settingStorage.getAvailable > 0 and i not in checkedTiles:
			checkedTiles.append(self)
			checkedTiles = i.setStorage(settingStorage, checkedTiles)
	return checkedTiles
	pass

func setAttributes():
	pass

func setPlantsGrowing(plants:Array):
	plantGrowing = plants
	
