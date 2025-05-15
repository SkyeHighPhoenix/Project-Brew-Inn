extends Node2D



##DESIGNERS: these should be all of the variables you need to change
##MacineInfo list populated as 
#[recipeDictionary{[inputResources]:[outputResources]}, tileLocation(vector2i), [ticksToRefine,inputStorageCap,outputStorageCap,maxBatchSize]]
const machineInfo = {
	"bottlingUnit":[{["appleJuice"]:["appleJuiceBottled"],
	["orangeJuice"]:["orangeJuiceBottled"],["blueberryJuice"]:["blueberryJuiceBottled"],
	["lemonLimeMix"]:["lemonLimeMixBottled"],["tomatoJuice"]:["tomatoJuiceBottled"],
	["pineappleJuice"]:["pineappleJuiceBottled"],["lemonade"]:["lemonadeBottled"],
	["limenade"]:["limenadeBottled"],["cola"]:["colaBottled"],
	["orangeSoda"]:["orangeSodaBottled"],["appleConcentrate"]:["appleConcentrateBottled"],
	["orangeConcentrate"]:["orangeConcentrateBottled"],["blueberryConcentrate"]:["blueberryConcentrateBottled"],
	["lemonLimeConcentrate"]:["lemonLimeConcentrateBottled"],
	["mixedBerryConcentrate"]:["mixedBerryConcentrateBottled"],["coffee"]:["coffeeBottled"],
	["greenTea"]:["greenTeaBottled"],["peppermintTea"]:["peppermintTeaBottled"],
	["flavouredWater"]:["waterBottled"]},Vector2i(2,7),[80,75,250,5]],
	
	"carbonator":[{["appleCiderFlat"]:["AppleCider"],["pearCiderFlat"]:["pearCider"],
	["strawberryCiderFlat"]:["strawberryCider"],["raspberryCiderFlat"]:["raspberryCider"],
	["blackberryCiderFlat"]:["blackberryCider"],["micedBerryCiderFlat"]:["mixedBerryCider"],
	["lemonadeMix"]:["lemonade"],["limenadeMix"]:["limenade"],["colaMix"]:["cola"],
	["orangeSodaMix"]:["orangeSoda"],["aleFlat"]:["ale"],["lagerFlat"]:["lager"],
	["gingerBeerFlat"]:["gingerBeer"],["rootBeerFlat"]:["rootBeer"]},Vector2i(3,6), [250,100,100,15]],
	
	"dehydrator":[{["appleJuice"]:["appleConcentrate"],["orangeJuice"]:["orangeConcentrate"],
	["blueberryJuice"]:["blueberryConcentrate"],["lemonLimeMix"]:["lemonLimeConcentrate"],
	["mixedBerryJuice"]:["mixedBerryConcentrate"]}, Vector2i(6,6), [240,150,150,15]],
	
	"fermenter":[{["appleJuice"]:["appleCiderFlat"],["pearJuice"]:["pearCiderFlat"],
	["strawberryJuice"]:["strawberryCiderFlat"],["raspberryJuice"]:["raspberryCiderFlat"],
	["blackberryJuice"]:["blackberryCiderFlat"],["mixedBerryJuice"]:["mixeBerryCiderFlat"],
	["aleMix"]:["aleFlat"],["lagerMix"]:["lagerFlat"],
	["rootBeerMix"]:["rootBeerFlat"],["gingerBeerMix"]:["gingerBeerFlat"]}, Vector2i(4,7), [600,75,75,15]], 
	
	"industrialMixer":[{["lemonJuice","LimeJuice"]:["lemonLimeMix"],
	["lemonJuice","drinkingWater"]:["lemonadeMix"],["limeJuice","drinkingWater"]:["limenadeMix"],
	["strawberryJuice","raspberryJuice","blackberryJuice"]:["mixedBerryJuice"],
	["teaCrop","drinkingWater"]:["greenTea"],["coffeeCrop","drinkingWater"]:["coffee"],
	["orangeConcentrate","sugarcaneWashed","vanillaWashed"]:["orangeSodaMix"],
	["drinkingWater", "sugarcaneWashed"]:["colaBase"],
	["colaBase","cinnamonWashed","vanillaWashed"]:["colaMix"],
	["maltWashed","drinkingWater"]:["aleMix"],
	["hopsWashed","drinkingWater"]:["lagerMix"],
	["drinkingWater","sarsaparillaWashed","nutmegWashed"]:["rootBeerMix"],
	["gingerWashed","sugarcaneWashed","drinkingWater"]:["gingerBeerMix"],
	["peppermintCrop","drinkingWater"]:["peppermintTea"],
	["drinkingWater","mintWashed"]:["flavouredWater"]}, Vector2i(0,8), [400,375,375,40]], 
	
	"juicer":[{["appleCrop"]:["appleJuice"],["orangeCrop"]:["orangeJuice"],
	["blueberryCrop"]:["blueberryJuice"],["lemonCrop"]:["lemonJuice"],
	["limeCrop"]:["limeJuice"],["tomatoCrop"]:["tomatoJuice"],
	["pineappleCrop"]:["pineappleJuice"],["pearCrop"]:["pearJuice"],
	["strawberryCrop"]:["strawberryJuice"], ["raspberryCrop"]:["raspberryJuice"],
	["blackberryCrop"]:["blackberryJuice"]}, Vector2i(6,4), [150,100,100,10]], 
	
	"washer":[{["gingerCrop"]:["gingerWashed"],["hopsCrop"]:["hopsWashed"],
	["sarsaparillaCrop"]:["sarsaparillaWashed"],["maltCrop"]:["maltWashed"],
	["sugarcaneCrop"]:["sugarcaneWashed"],["cinnamonCrop"]:["cinnamonWashed"],
	["mintCrop"]:["mintWashed"],["nutmegCrop"]:["nutmegWashed"],
	["peppermintCrop"]:["peppermintWashed"],["vanillaCrop"]:["vanillaWashed"]}, Vector2i(3,8), [300,250,250,50]], 
	
	"waterProcessingUnit":[{["waterUnrefined"]:["drinkingWater"]}, Vector2i(6,8), [2400,40,400,40]]}

#These are all placeholder values that will be changed by code once the building is created
var validRecipesDict = {["placeholderInput0"]:["placeholderOutput0", "placeholderOutput1"], ["placeholderInput1"]:["placeholderOutput2"], ["placeholderInput2", "placeholderInput3"]:["placeholderOutput3"]}	
var storedUnrefinedResources = {}
var storedRefinedResources = {}
var ticksToRefine = 100
var inputStorageCap = 500
var outputStorageCap = 500
var maxBatchSize = 30 ##DESIGNERS: must be a multiple of the length of ALL recipe lists i.e. if there are recipes with 2 inputs and 3 outputs then batch size must be a multiple of 2 and 3
##DESIGNERS: this is the end of the variables you should have to change

signal setTileAt(onSet, onMap)
var forceFullBatch = false
var ticksUntilAutostart = ticksToRefine * 0.2
var tick = 0
var active = false
var activeRecipe
var minSize
var tilePosition = Vector2i() # liles main tile position
var tileSize = Vector2i() # 0,0 is a 1 by 1
var tileType = ""
var worker = true
var workerCapacity = 20
var workerSpeed = 200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
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

func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, connectedTiles:Array):
	GlobalTick.tickIncreased.connect(tickIncrease)
	tileType = buildingType
	tilePosition = coordinates
	tileSize = size
	var keys=validRecipesDict.keys()
	minSize = 0
	for i in range(len(keys)):
		if len(keys[i])>minSize:
			minSize=len(keys[i])
		if len(validRecipesDict[keys[i]])>minSize:
			minSize=len(keys[i])
			
	validRecipesDict = machineInfo[tileType][0]
	for i in validRecipesDict:
		for input in i:
			storedUnrefinedResources[input] = 0
		for output in validRecipesDict[i]:
			storedRefinedResources[output] = 0
	var values = machineInfo[tileType][2]
	ticksToRefine = values[0]
	inputStorageCap = values[1]
	outputStorageCap = values[2]
	maxBatchSize = values[3]
	print(storedUnrefinedResources)
	print(storedRefinedResources)
	print(ticksToRefine,inputStorageCap,outputStorageCap,maxBatchSize)
	setTileAt.emit(machineInfo[tileType][1], tilePosition)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func grabResources(manual = false):
	for i in storedUnrefinedResources:
		if storedUnrefinedResources[i] < inputStorageCap:
			if storedUnrefinedResources[i]+workerCapacity > inputStorageCap:
				storedUnrefinedResources[i]+=GlobalInventory.subtractResource(i, inputStorageCap-storedUnrefinedResources[i])
			else:
				storedUnrefinedResources[i]+=GlobalInventory.subtractResource(i, workerCapacity)
	if manual:
		for i in storedUnrefinedResources:
			storedUnrefinedResources[i]+=GlobalInventory.subtractResource(i, inputStorageCap-storedUnrefinedResources[i])

func sendResources(manual = false):
	for i in storedRefinedResources:
		if storedRefinedResources[i] > workerCapacity:
			GlobalInventory.addResource(i, workerCapacity)
			storedRefinedResources[i] -= workerCapacity
		else:
			GlobalInventory.addResource(i, storedRefinedResources[i])
			storedRefinedResources[i] = 0
	if manual:
		for i in storedRefinedResources:
			GlobalInventory.addResource(i, storedRefinedResources[i])
			storedRefinedResources[i] = 0
	pass

func increaseResources():#if active = true: it checks if it is done yet, otherwise it checks if it should autostart
	var emptySpace = outputStorageCap
	if active:
		if tick == ticksToRefine:
			completeRecipe(activeRecipe, emptySpace)
	else:
		if tick == ticksUntilAutostart:
			print("attempting to start production machine")
			tick = 0
			activeRecipe = verify(emptySpace)#returns a recipe that can be started if there is one. requires the amount of empty space.
			if activeRecipe != []:
				print("Starting "+str(activeRecipe)+" recipe")
				activate()#sets active to true and resets tick to 0
			else:
				print("failed")

func activate():#sets active to true and resets tick to 0
	if active == false:
		active = true
		tick = 0

func tickIncrease():#called every tick
	tick += 1
	increaseResources()#if active = true: it checks if it is done yet, otherwise it checks if it should autostart
	
func verify(emptySpace):#returns a recipe that can be started if there is one. requires the amount of empty space.
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
	
func completeRecipe(recipe, emptySpace):#takes and adds the appropriate resources for the given recipe and amount of space in output storage. it does no checks to see if the recipe is right so the recipe must have been checked with verify()
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
	print("input amount = "+str(inputAmount)+", output amount = "+str(outputAmount))
	for i in range(numOfInputs):
		storedUnrefinedResources[recipe[i]] -= inputAmount
	for i in range(numOfOutputs):
		storedRefinedResources[validRecipesDict[recipe][i]] += outputAmount
	
	print("recipe completed")
	print(storedUnrefinedResources)
	print(storedRefinedResources)
	active = false
	tick = 0
