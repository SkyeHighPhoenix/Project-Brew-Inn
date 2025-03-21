extends Node2D
var tick = 0
var ticksToRefine = 100
var ticksUntilAutostart = ticksToRefine * 0.2
var resourcesOnRefine = 25
var inputStorageCap = 500
var outputStorageCap = 500
var storedUnrefinedResources = 0
var storedRefinedResources = 0
var forceFullBatch = false
var validRecipiesDict = {"wheat":"flour", "milk":"cream", ["cream", "salt"]:"butter"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTick.tickIncreased.connect(tickIncrease)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return

func increaseResources():
	if tick == ticksToRefine:
		storedRefinedResources += resourcesOnRefine
		print(storedRefinedResources)
		tick = 0

func tickIncrease():
	tick += 1
	increaseResources()
	
