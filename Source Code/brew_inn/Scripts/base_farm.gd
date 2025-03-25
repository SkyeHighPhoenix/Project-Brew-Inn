extends Node2D
var tick = 0
var ticksToGrow = 100
var resourcesOnHarvest = 25
var StorageCap = 500
var storedResources = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTick.tickIncreased.connect(tickIncrease)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return

func increaseResources():
	if tick % ticksToGrow:
		storedResources += resourcesOnHarvest
		print(storedResources)
		tick = 0
				

func tickIncrease():
	tick += 1
	increaseResources()
	
