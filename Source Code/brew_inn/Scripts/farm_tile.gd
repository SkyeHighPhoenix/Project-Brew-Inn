extends Node2D
# when tile is deleted you must remove all instances of this tile 
# from connected tiles and storage

signal setTileAt

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

	pass

func tickIncrease():
	tick += 1
	increaseResources()

func checkOutputs(coordsIn):
	# take block
	# check if it matches an input or output on my one
	# add to inputs and outputs respectively
	pass


func setAttributes():
	pass

func setPlantsGrowing(plants:Array):
	plantGrowing = plants
	
