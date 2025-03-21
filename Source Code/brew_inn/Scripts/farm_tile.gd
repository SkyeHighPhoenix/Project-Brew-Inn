extends Node2D
# when tile is deleted you must remove all instances of this tile 
# from connected tiles and storage

var ticksToGrow = 100
var resourcesOnHarvest = 25
var storageCap = 500

var tilePosition = Vector2i() # liles main tile position
var tileSize = Vector2i() # 0,0 is a 1 by 1
var tileType = ""
var plantGrowing = ""
var Irrigated = false

var growthStage = 0
var connections = []

var storedResources = 0
var localStorage = true
var storageBox = null
var plotsToStorage = null


var tick = 0




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

func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	Irrigated = irrigationStatus
	tileType = buildingType
	tilePosition = coordinates
	tileSize = size
	match tileType:
		"cropPlot":
			checkConnections(connectedTiles)
			checkForStorage()
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

func checkConnections(tiles):
	for i in tiles:
		print(i.tileType)
		if i.tileType == "cropPlot":
			connections.append(i)
			i.addConnection(self)
		elif i.tileType == "storage" and storageBox == null:
			newStorage(0,i)
	
func checkForStorage(): 
	# checks for any available storage boxes to connect to when a crop plot
	var currentSelection = null
	for i in connections:
		print(i)
		if i.plotsToStorage != null:
			if currentSelection == null:
				currentSelection = i
			if i.plotsToStorage < currentSelection.plotsToStorage:
				currentSelection = i
	if currentSelection != null and currentSelection.storageBox.getAvailable() >0:
		plotsToStorage = currentSelection.plotsToStorage + 1
		storageBox = currentSelection.storageBox
		storageBox.addNode(self)
		for i in connections:
			if i.storageBox != storageBox:
				if (i.plotsToStorage == null) or (i.plotsToStorage > plotsToStorage + 1):
					i.checkForStorage()
		
func addConnection(toConnect):
	connections.append(toConnect)
	pass

func newStorage(distance, settingStorage): # crop plot exclusive
	if plotsToStorage == null:
		plotsToStorage = distance + 1
	if distance < plotsToStorage:
		settingStorage.addNode(self)
		storageBox = settingStorage
		return connections
	else:
		return []
		
func setStorage(settingStorage, checkedTiles = []):
	# messy tree traversal alghorythm, idrc so long as it works
	for i in connections:
		if i.storageBox == null and settingStorage.getAvailable > 0:
			settingStorage.addNode(i)
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
	
