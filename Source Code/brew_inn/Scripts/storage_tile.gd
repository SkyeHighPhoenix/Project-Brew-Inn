extends Node2D
const maxTiles = 6
const startCapacity = 100
const validTypes = ['cropPlot']
const tileType = "storageBox"
var storageCapacity = 0
var itemCount:int = 0
var itemCounts = {}
var assignedCoords = []
var tilePosition



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	storageCapacity = startCapacity
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass
	
func addResources(count:int):
	itemCount += count
	if itemCount > storageCapacity:
		itemCount = storageCapacity
	pass
	
func createBuilding(buildingType:String, coordinates:Vector2i, tileSize:Vector2i,connectedTiles:Array):
	tilePosition = coordinates
	connectPlots(connectedTiles)

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
	print(assignedCoords)

func addNode(nodeCoords:Vector2i):
	if nodeCoords not in assignedCoords:
		assignedCoords.append(nodeCoords)
	pass

func getAvailable():
	return maxTiles - len(assignedCoords)
