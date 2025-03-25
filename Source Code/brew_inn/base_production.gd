extends Node2D
var tick = 0
var ticksToRefine = 100
var ticksUntilAutostart = ticksToRefine * 0.2
var resourcesOnRefine = 25
var inputStorageCap = 500
var outputStorageCap = 500
var storedUnrefinedResources = {"wheat":0, "milk":0, "cream":10, "salt":10}
var storedRefinedResources = {"flour":0,"cream":0, "butter":0}
var forceFullBatch = false
var validRecipiesDict = {["wheat"]:["flour"], ["milk"]:["cream"], ["cream", "salt"]:["butter"]}	
var active = false
var activeRecipe
var batchSize = 20 #must be a multiple of the length of ALL recipie lists i.e. if there are recipies with 2 inputs and 3 outputs then batch size must be a multiple of 2 and 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTick.tickIncreased.connect(tickIncrease)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return

func increaseResources():
	if active:
		if tick == ticksToRefine:
			completeRecipe(activeRecipe)
	else:
		if tick == ticksUntilAutostart:
			print("attempting to start production machine")
			tick = 0
			activeRecipe = verify()
			if activeRecipe != []:
				print("Starting "+str(activeRecipe)+" recipe")
				activate()

func activate():
	if active == false:
		print(storedUnrefinedResources)
		print(storedRefinedResources)
		active = true
		tick = 0

func tickIncrease():
	tick += 1
	increaseResources()
	
func verify():
	var recipe
	var valid = true
	if forceFullBatch:
		return
	else:
		var keys = validRecipiesDict.keys()
		for i in range(len(keys)):
			valid = true
			for j in range(len(keys[i])):
				if storedUnrefinedResources[keys[i][j]] < len(validRecipiesDict[keys[i]]):
					valid = false
			if valid:
				return keys[i]
		print("failed")
		return []
		
func completeRecipe(recipe):
	for i in range(len(recipe)):
		storedUnrefinedResources[validRecipiesDict[recipe[i]]]-=1
	for i in range(len(recipe)):
		storedRefinedResources[recipe[i]]+=1
	print("recipe completed")
	active = false
	tick = 0
