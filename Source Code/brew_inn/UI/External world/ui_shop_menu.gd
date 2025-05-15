extends Node2D
## put the starting prices list as a dictionary {placeholder:£placeholder price}
var structure="Null"
var numberOfStruct = {"Null":0, "Orchard":0, "Bushes":0, "Crop Plot Storage":0, "Crop Plot Body":0, "Herb garden":0, "Greenhouse":0, "Irigation Well":0, "Irigation main":0, "Irigation split":0, "Irigation turn":0, "Juicer":0, "Fermenter":0, "Washer":0, "Dehydrator":0, "Carbonator":0, "Water Processing Unit":0, "Industrial Mixer":0, "Bottling Unit":0}
var buildingPrice = 150*1.05**(numberOfStruct[structure]-1)
var licensesShopCostDict = {"Juices":0, "Concentrates":150, "Ciders":400, "Beers":1175, "Soft Drinks":850, "Hot Drinks":1450}
var workersShopCostDict = {"Standard":[80, 3], "Specialist":[100, 2]}#second number is how often they get paid in days

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for shopItem in $machinesTab/shopScrollableMachinesTab/machinesItemList.get_children():
		shopItem.get_node("purchaseButtonM1").pressed.connect(shopButtonPressed.bind(shopItem))
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	hide();

func shopButtonPressed(button):
	print(button.name)
	pass
