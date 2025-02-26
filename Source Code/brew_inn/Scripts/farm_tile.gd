extends Node2D
var tilePosition = Vector2i() # liles main tile position
var tileSize = Vector2i() # 0,0 is a 1 by 1
var type = ""
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
var resourceType = "wheat"
var storedResources = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTick.tickIncrease.connect(tickIncrease)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if storedResources > storageCap:
		storedResources = storageCap
	pass
	
func increaseResources():
	if tick % ticksToGrow == 0:
		if localStorage == true:
			storedResources += resourcesOnHarvest
			print(storedResources)

func createBuilding(buildingType:String, coordinates:Vector2i, tileSize:Vector2i, irrigationStatus:bool):
	Irrigated = irrigationStatus
	type = buildingType
	tilePosition = coordinates
	pass

func tickIncrease():
	tick += 1
	increaseResources()

func checkOutputs(coordsIn):
	# take block
	# check if it matches an input or output on my one
	# add to inputs and outputs respectively
	pass
	
