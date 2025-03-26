extends Node2D
var tick = 0
var ticksToRefine = 100
var ticksUntilAutostart = ticksToRefine * 0.2
var resourcesOnRefine = 25
var inputStorageCap = 500
var outputStorageCap = 500
var storedUnrefinedResources = {"wheat":19, "milk":2, "cream":2, "salt":2}
var storedRefinedResources = {"flour":0,"cream":0, "butter":0, "salt":0}
var forceFullBatch = true
var validRecipesDict = {["wheat"]:["flour", "salt"], ["milk"]:["cream"], ["cream", "salt"]:["butter"]}	
var active = false
var activeRecipe
var maxBatchSize = 20 #DESIGNERS: must be a multiple of the length of ALL recipe lists i.e. if there are recipes with 2 inputs and 3 outputs then batch size must be a multiple of 2 and 3
var minSize

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTick.tickIncreased.connect(tickIncrease)
	
	var keys=validRecipesDict.keys()
	minSize = 0
	for i in range(len(keys)):
		if len(keys[i])>minSize:
			minSize=len(keys[i])
		if len(validRecipesDict[keys[i]])>minSize:
			minSize=len(keys[i])
	
	print(storedUnrefinedResources)
	print(storedRefinedResources)

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
			else:
				print("failed")

func activate():
	if active == false:
		active = true
		tick = 0

func tickIncrease():
	tick += 1
	increaseResources()
	
func verify():
	var valid = true
	var emptySpace = outputStorageCap
	var keys = storedRefinedResources.keys()
	var chosenRecipe
	var batchSizeMultiple
	for i in range(len(keys)):
		emptySpace -= storedRefinedResources[keys[i]]
	if forceFullBatch && maxBatchSize > emptySpace:
		return []
	keys = validRecipesDict.keys()
	for i in range(len(keys)):
		valid = true
		chosenRecipe = keys[i]
		if valid && forceFullBatch:
			if emptySpace < maxBatchSize:
				valid = false
			for j in range(len(chosenRecipe)):
				if storedUnrefinedResources[chosenRecipe[j]]<maxBatchSize/len(chosenRecipe):
					valid = false
		elif valid && !forceFullBatch:
			batchSizeMultiple = len(chosenRecipe)*len(validRecipesDict[chosenRecipe])
			if emptySpace < batchSizeMultiple:
				valid = false
			for j in range(len(chosenRecipe)):
				if storedUnrefinedResources[chosenRecipe[j]]<(1.0/len(chosenRecipe))*batchSizeMultiple:
					valid = false
		if valid:
			print("yippee")
			return chosenRecipe
	print("aww")
	return []
		
func completeRecipe(recipe):
	var x = true
	var unrefinedResources = []
	var batchSizeMultiple = len(recipe)*len(validRecipesDict[recipe])
#	for i in range(len(recipe)):
#		unrefinedResources.append()
#	while x == true:
#		for i in range(len(recipe)):
			
	
	
	
	print("recipe completed")
	print(storedUnrefinedResources)
	print(storedRefinedResources)
	active = false
	tick = 0
