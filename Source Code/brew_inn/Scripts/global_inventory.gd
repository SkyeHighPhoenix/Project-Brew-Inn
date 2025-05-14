extends Node2D

var categories = {"wood":["oak", "cherry", "beech", "willow", "hazel"], "cake":["chocolate guinness cake", "carrot cake"]}

var currency = 0
var resourceCount = {"cherry":0, "beech":0, "willow":0, "hazel":0, "chocolate guinness cake":0, "carrot cake":0}
# Called when the node enters the scene tree for the first time.

var level = 1
var expProgression = 500*1.125**(level-1)
var exp = 0

func addCurrency(amount):
	currency+=amount
		
func subtractCurrency(amount):
	currency-=amount

func addResource(resource, amount):
	if resource in resourceCount:
		resourceCount[str(resource)]+=amount
		print (resourceCount)
		print (categories)
	else:
		return false
	
func subtractResource(resource, amount):
	if resourceCount[str(resource)]>=amount:
		resourceCount[str(resource)]-=amount
		return amount
	else:
		var returnAmount=resourceCount[str(resource)]
		resourceCount[str(resource)]=0
		return returnAmount

func newResource(name, categoryList, initialAmount=0):
	for i in range(len(categoryList)):
		categories[categoryList[i]].append(name)
	resourceCount[name]=initialAmount
	print (resourceCount)
	print (categories)

func addEXP(amount):
	exp+=amount
	if exp >= expProgression:
		exp -= expProgression
		level+=1
