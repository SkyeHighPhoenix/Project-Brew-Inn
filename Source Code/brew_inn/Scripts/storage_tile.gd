extends Node2D
const maxTiles = 6
const startCapacity = 100
const validTypes = ['cropPlot']
const tileType = "storage"
var storageCapacity = 100
var itemCount:int = 0
var cropActive = null
var assignedNodes = []
var tilePosition
signal setTile(onSet, onMap)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	storageCapacity = startCapacity
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass
	
func addResources(count:int):
	print(itemCount)
	itemCount += count
	if itemCount > storageCapacity:
		itemCount = storageCapacity
	pass
	
func createBuilding(buildingType:String, coordinates:Vector2i, tileSize:Vector2i,connectedTiles:Array):
	tilePosition = coordinates
	connectPlots(connectedTiles)
	setTile.emit(Vector2i(1,1), tilePosition)

func connectPlots(connections):
	var checkedPlots = []
	var plotsToCheck = connections
	var distance = 0
	while plotsToCheck != [] and getAvailable() > 0:
		var newChecklist = []
		for i in plotsToCheck:
			print("plotCheck ", distance, " ", i)
			if i.tileType == 'cropPlot' and getAvailable() > 0:
				var plotList = i.newStorage(distance, self)
				for plot in plotList:
					newChecklist.append(plot)
		plotsToCheck = []
		for i in newChecklist:
			if i not in checkedPlots:
				plotsToCheck.append(i)
		distance += 1
		pass
	print(assignedNodes, "connectPLots")

func changeCrop(newCrop):
	cropActive = newCrop
	for i in assignedNodes:
		i.updateCropType(newCrop)
	pass

func addNode(node):
	if node not in assignedNodes:
		assignedNodes.append(node)
		node.updateCropType(cropActive)
		print(assignedNodes, "AddNode")
	pass

func getAvailable():
	return maxTiles - len(assignedNodes)
