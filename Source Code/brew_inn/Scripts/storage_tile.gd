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
	for i in connectedTiles:
		if i.tileType == 'cropPlot' and getAvailable() > 0:
			i.setStorage(self)
	pass

func addNode(nodeCoords:Vector2i):
	assignedCoords.append(nodeCoords)
	pass

func getAvailable():
	return maxTiles - len(assignedCoords)
