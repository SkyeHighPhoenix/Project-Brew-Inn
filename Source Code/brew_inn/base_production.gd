extends Node2D
var tick = 0
var ticksToRefine = 100
var ticksUntilAutostart = ticksToRefine * 0.2
var resourcesOnRefine = 25
var inputStorageCap = 500
var outputStorageCap = 500
var storedUnrefinedResources = {"wheat":30, "milk":200, "cream":8, "salt":16}
var storedRefinedResources = {"flour":0,"cream":0, "butter":0, "salt":0}
var forceFullBatch = false
var validRecipesDict = {["wheat"]:["flour", "salt"], ["milk"]:["cream"], ["cream", "salt"]:["butter"]}	
var active = false
var activeRecipe
var maxBatchSize = 30 #DESIGNERS: must be a multiple of the length of ALL recipe lists i.e. if there are recipes with 2 inputs and 3 outputs then batch size must be a multiple of 2 and 3
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
	var emptySpace = outputStorageCap
	
	if active:
		if tick == ticksToRefine:
			completeRecipe(activeRecipe, emptySpace)
	else:
		if tick == ticksUntilAutostart:
			print("attempting to start production machine")
			tick = 0
			activeRecipe = verify(emptySpace)
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
	
func verify(emptySpace):
	var valid = true
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
			return chosenRecipe
	return []
	
func completeRecipe(recipe, emptySpace):
	var acceptableAmount = true
	var unrefinedResources = []
	var numOfOutputs = len(validRecipesDict[recipe])
	var numOfInputs = len(recipe)
	var outputAmount = -numOfInputs
	var inputAmount = -numOfOutputs
	
	for i in range(numOfInputs):
		unrefinedResources.append(storedUnrefinedResources[recipe[i]])
	while acceptableAmount == true:
		inputAmount += numOfOutputs
		outputAmount += numOfInputs
		for i in range(len(unrefinedResources)):
			if unrefinedResources[i]<numOfOutputs:
				acceptableAmount = false
			else:
				unrefinedResources[i] -= numOfOutputs
				if (inputAmount + numOfOutputs) > emptySpace:
					acceptableAmount = false
				elif (inputAmount + numOfOutputs) > maxBatchSize:
					acceptableAmount = false
	print("inputamount = "+str(inputAmount)+", outputamount = "+str(outputAmount))
	for i in range(numOfInputs):
		storedUnrefinedResources[recipe[i]] -= inputAmount
	for i in range(numOfOutputs):
		storedRefinedResources[validRecipesDict[recipe][i]] += outputAmount
	
	print("recipe completed")
	print(storedUnrefinedResources)
	print(storedRefinedResources)
	active = false
	tick = 0
