extends Node2D
## put the starting prices list as a dictionary {placeholder:£placeholder price}
var number
var shopCostDictFarming = {"Orchard":150*1.05^(number-1), "Bushes":300*1.05^(number-1), "Crop Plot Storage":750*1.05^(number-1), "Crop Plot Body":100*1.01^(number-1), "Herb garden":1000*1.05^(number-1), "Greenhouse":1500*1.05^(number-1), "Irigation Well":200*1.1^(number-1), "Irigation main":80*1.02^(number-1), "Irigation split":100*1.05^(number-1), "Irigation turn":100*1.02^(number-1)}
var shopCostDictMachines = {"Juicer":325*1.1^(number-1), "Fermenter":550*1.1^(number-1), "Washer":425*1.1^(number-1), "Dehydrator":675*1.1^(number-1), "Carbonator":850*1.1^(number-1), "Water Processing Unit":900*1.15^(number-1), "Industrial Mixer":1500*1.25^(number-1), "Bottling Unit":500*1.1^(number-1)}
var shopCostDictLicenses = {"Juices":0, "Concentrates":150, "Ciders":400, "Beers":1175, "Soft Drinks":850, "Hot Drinks":1450}
var shopCostDictWorkers = {"Standard":[80, "per 3 days"], "Specialist":[100, "per 2 days"]}

## putting this here since I don't know where to put it
var level
var expProgression = 500*1.125^(level-1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
