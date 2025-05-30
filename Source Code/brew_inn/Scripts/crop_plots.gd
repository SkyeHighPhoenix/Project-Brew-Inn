extends "res://Scripts/farm_tile.gd"


var plotsToStorage = null
var connections = []
var storageBox = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func increaseResources():
	if tick % ticksToGrow == 0:
		if storageBox!=null and Irrigated and storageBox.cropActive != null:
			storageBox.addResources(resourcesOnHarvest)

func checkConnections(tiles):
	var tempStorage = null
	for i in tiles:
		print(i.tileType, " CheckConnections")
		if i.category == "cropPlots":
			print("found")
			connections.append(i)
			i.addConnection(self)
		elif i.tileType == "Storage" and storageBox == null and tempStorage == null:
			tempStorage = i
	if tempStorage != null:
		if tempStorage.getAvailable() > 0:
			newStorage(0,tempStorage)
			


func checkForStorage(): 
	# checks for any available storage boxes to connect to when a crop plot
	var currentSelection = null
	for i in connections:
		print(i, " checkForStorage, plotsToStorage = ", plotsToStorage)
		if i.plotsToStorage != null:
			if currentSelection == null:
				currentSelection = i
			if i.plotsToStorage < currentSelection.plotsToStorage:
				currentSelection = i
	if currentSelection != null and currentSelection.storageBox.getAvailable() >0:
		plotsToStorage = currentSelection.plotsToStorage + 1
		storageBox = currentSelection.storageBox
		print("uhh")
		if storageBox.cropActive != null:
				updateCropType(storageBox.cropActive)
		storageBox.addNode(self)
		for i in connections:
			if i.storageBox != storageBox:
				if (i.plotsToStorage == null) or (i.plotsToStorage > plotsToStorage + 1):
					i.checkForStorage()
					
func setStorage(settingStorage, checkedTiles = []):
	# messy tree traversal alghorythm, idrc so long as it works
	for i in connections:
		print(i.tileType, "Raaa")
		if i.storageBox == null and settingStorage.getAvailable() > 0:
			settingStorage.addNode(i)
			i.storageBox = settingStorage
			i.plotsToStorage = plotsToStorage+1
			if settingStorage.cropActive != null:
				updateCropType(settingStorage.cropActive)
	for i in connections:
		if i.storageBox == settingStorage and settingStorage.getAvailable() > 0 and i not in checkedTiles:
			checkedTiles.append(self)
			checkedTiles = i.setStorage(settingStorage, checkedTiles)
	return checkedTiles
	pass

func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	print("")
	category = "cropPlots"
	GlobalTick.tickIncreased.connect(tickIncrease)
	Irrigated = irrigationStatus
	tileType = buildingType
	tilePosition = coordinates
	tileSize = size
	tilemapLocations = {"cropPlot":Vector2i(2,6),"hops":Vector2i(9,0), "ginger":Vector2i(9,1),"sugarcane":Vector2i(9,2),"sarsaparilla":Vector2i(9,3)}
	setTileAt.emit(tilemapLocations[buildingType], tilePosition)
	checkConnections(connectedTiles)
	checkForStorage()
	tileType = buildingType
	if storageBox != null:
		if storageBox.cropActive != null:
			updateCropType(storageBox.cropActive)
			pass
func addConnection(toConnect):
	connections.append(toConnect)
	pass

func updateCropType(newCrop:String):
	plantGrowing = newCrop
	setTileAt.emit(tilemapLocations[newCrop], tilePosition)
	tileType = newCrop
	setPlantsGrowing([newCrop])
	# apply visual changes
	pass
		

func newStorage(distance, settingStorage): # crop plot exclusive
	if plotsToStorage == null:
		plotsToStorage = distance + 1
	if distance < plotsToStorage:
		settingStorage.addNode(self)
		storageBox = settingStorage
		if settingStorage.cropActive != null:
			updateCropType(settingStorage.cropActive)
		setStorage(settingStorage)
		return connections
	else:
		return []
