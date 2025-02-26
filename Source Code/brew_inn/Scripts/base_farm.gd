extends Node2D
var tick = 0
var ticksToGrow = 100
var resourcesOnHarvest = 25
var localStorage = true
var storageCap = 500
var resourceType = "wheat"
var storedResources = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTick.tickIncreased.connect(tickIncrease)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if storedResources > storageCap:
		storedResources = storageCap

func increaseResources():
	if tick % ticksToGrow == 0:
		if localStorage == true:
			storedResources += resourcesOnHarvest
			print(storedResources)

func tickIncrease():
	tick += 1
	increaseResources()
