extends Control

signal setTile
const structPriceMultipliers = {"Null":1, "orchard":1.05, "berryBushes":1.05, "storage":1.05, 
"cropPlot":1.05, "herbGarden":1.05, "greenhouse":1.05, "irwell":1.05, 
"irstraight":1.05, "irjunction":1.05, "irbend":1.05, "juicer":1.1, 
"fermentor":1.1, "washer":1.1, "dehydrator":1.1, "carbonator":1.1, 
"waterProcessingUnit":1.1, "industrialMixer":1.1, "bottlingUnit":1.1}
var tabs = ["farmingTab", "machinesTab", "licensesTab", "workersTab"]
## put the starting prices list as a dictionary {placeholder:£placeholder price}
const structCategories = {"irrigation":["irbend", "irjunction", "irstraight", "irwell"],
"productionMachine":["fermentor", "juicer", "washer", "dehydrator", "carbonator", 
"waterProcessingUnit", "industrialMixer", "bottlingUnit"], 
"herbGarden":["herbGarden"], 
"cropPlot":["cropPlot"], "standardFarm":["orchard", "berryBushes", "greenhouse"],
"storage":["storage"]}
var numberOfStruct = {"Null":0, "orchard":0, "berryBushes":0, "storage":0, 
"cropPlot":0, "herbGarden":0, "greenhouse":0, "irwell":0, 
"irstraight":0, "irjunction":0, "irbend":0, "juicer":0, 
"fermentor":0, "washer":0, "dehydrator":0, "carbonator":0, 
"waterProcessingUnit":0, "industrialMixer":0, "bottlingUnit":0}
var numberOfWorkers = {"standardWorker":0, "specialistWorker":0}
var licensesShopCostDict = {"Juices":0, "Concentrates":150, "Ciders":400, "Beers":1175, "Soft Drinks":850, "Hot Drinks":1450}
var workersShopCostDict = {"Standard":[80, 3], "Specialist":[100, 2]}#second number is how often they get paid in days

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for shopItem in $machinesTab/shopScrollableMachinesTab/machinesItemList.get_children():
		shopItem.get_node("purchaseButtonM1").pressed.connect(shopButtonPressed.bind(shopItem))
		shopItem.get_node("shopItemCost").text = str(getBuildingPrice(shopItem.name))
		shopItem.get_node("currentlyOwnedAmountLabel").text = str(numberOfStruct[shopItem.name])
	for shopItem in $farmingTab/shopScrollableFarmingTab/farmingItemList.get_children():
		shopItem.get_node("purchaseButtonF1").pressed.connect(shopButtonPressed.bind(shopItem))
		shopItem.get_node("shopItemCost").text = str(getBuildingPrice(shopItem.name))
		shopItem.get_node("currentlyOwnedAmountLabel").text = str(numberOfStruct[shopItem.name])
	for shopItem in $workersTab/shopScrollableWorkersTab2/workersItemList.get_children():
		shopItem.get_node("hireButton").pressed.connect(shopButtonPressed.bind(shopItem))
		shopItem.get_node("currentlyOwnedAmountLabel").text = str(numberOfWorkers[shopItem.name])
	$machinesTabButton.pressed.connect(shopNavigationPressed.bind("machines"))
	$farmingTabLabel.pressed.connect(shopNavigationPressed.bind("farming"))
	$licensesTabButton.pressed.connect(shopNavigationPressed.bind("licenses"))
	$workerTabButton.pressed.connect(shopNavigationPressed.bind("worker"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getBuildingPrice(structure):
	var buildingPrice = 10*structPriceMultipliers[structure]**(numberOfStruct[structure])
	buildingPrice = round(buildingPrice * pow(10.0, 1)) / pow(10.0, 1)
	return buildingPrice
	
func _on_back_button_pressed() -> void:
	hide();

func shopButtonPressed(button):
	var tileName = button.name
	for i in structCategories:
		if tileName in structCategories[i]:
			if getBuildingPrice(tileName) <= GlobalInventory.currency:
				setTile.emit(tileName, i)
				GlobalInventory.currency -= getBuildingPrice(tileName)
				numberOfStruct[tileName] += 1
				button.get_node("shopItemCost").text = str(getBuildingPrice(button.name))
				button.get_node("currentlyOwnedAmountLabel").text = str(numberOfStruct[button.name])
				hide()
	if tileName == "standardWorker":
		if 80 <= GlobalInventory.currency:
			GlobalInventory.workerCredits += 3
			GlobalInventory.currency -= 80
			numberOfWorkers[button.name] += 1
			button.get_node("currentlyOwnedAmountLabel").text = str(numberOfWorkers[button.name])
	elif tileName == "specialistWorker":
		if 100 <= GlobalInventory.currency:
			GlobalInventory.workerCredits += 5
			GlobalInventory.currency -= 100
			numberOfWorkers[button.name] += 1
			button.get_node("currentlyOwnedAmountLabel").text = str(numberOfWorkers[button.name])

func shopNavigationPressed(button):
	for i in tabs:
		get_node(i).hide()
	match button:
		"machines":
			$machinesTab.show()
		"farming":
			$farmingTab.show()
		"licenses":
			$licensesTab.show()
		"worker":
			$workersTab.show()
	pass
