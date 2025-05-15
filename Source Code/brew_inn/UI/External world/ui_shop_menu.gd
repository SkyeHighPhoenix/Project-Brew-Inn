extends Control

signal setTile
## put the starting prices list as a dictionary {placeholder:£placeholder price}
const structCategories = {"irrigation":["irbend", "irjunction", "irstraight", "irwell"],
"productionMachine":["fermentor", "juicer", "washer", "dehydrator", "carbonator", 
"waterProcessingUnit", "industrialMixer", "bottlingUnit"], 
"herbGarden":["herbGarden"], 
"cropPlot":["cropPlot"], "standardFarm":["standardFarm"]}
var structure="Null"
var numberOfStruct = {"Null":0, "orchard":0, "berryBushes":0, "storage":0, 
"cropPlot":0, "herbGarden":0, "greenhouse":5, "irwell":0, 
"irstraight":0, "irjunction":0, "irbend":0, "juicer":0, 
"fermentor":0, "washer":0, "dehydrator":0, "carbonator":0, 
"waterProcessingUnit":0, "industrialMixer":0, "bottlingUnit":0}
var buildingPrice = 150*1.05**(numberOfStruct[structure]-1)
var licensesShopCostDict = {"Juices":0, "Concentrates":150, "Ciders":400, "Beers":1175, "Soft Drinks":850, "Hot Drinks":1450}
var workersShopCostDict = {"Standard":[80, 3], "Specialist":[100, 2]}#second number is how often they get paid in days

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(buildingPrice)
	structure = "Greenhouse"
	print(buildingPrice)
	for shopItem in $machinesTab/shopScrollableMachinesTab/machinesItemList.get_children():
		shopItem.get_node("purchaseButtonM1").pressed.connect(shopButtonPressed.bind(shopItem))
	for shopItem in $farmingTab/shopScrollableFarmingTab/farmingItemList.get_children():
		shopItem.get_node("purchaseButtonF1").pressed.connect(shopButtonPressed.bind(shopItem))
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	hide();

func shopButtonPressed(button):
	print(button.name)
	setTile.emit("irstraight", "irrigation")
	pass
