extends Node2D

var categories = {"wood":["oak", "cherry", "beech", "willow", "hazel"], "cake":["chocolate guinness cake", "carrot cake"]}

var currency = 0
var resourceCount = {"cherry":0, "beech":0, "willow":0, "hazel":0, "chocolate guinness cake":0, "carrot cake":0}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(resourceCount)
	newResource("oak", ["wood"])
	if addResource("balls", 99) == false:
		newResource("balls", ["wood", "cake"], 99)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func addCurrency(amount):
	currency+=amount
	
func subtractCurrency(amount):
	currency-=amount

func addResource(resource, amount):
	var matches = false
	var keys = resourceCount.keys()
	for i in range(len(keys)):
		if keys[i]==resource:
			matches = true
	if matches:
		resourceCount[str(resource)]+=amount
		print (resourceCount)
		print (categories)
	else:
		return false
	
func subtractResource(resource, amount):#expects checks to be done to ensure that there is enough before calling this
	resourceCount[str(resource)]-=amount

func newResource(name, categoryList, initialAmount=0):
	for i in range(len(categoryList)):
		categories[categoryList[i]].append(name)
	resourceCount[name]=initialAmount
	print (resourceCount)
	print (categories)
