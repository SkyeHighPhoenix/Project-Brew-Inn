extends Node2D

var categories = {"wood":["oak", "cherry", "beech", "willow", "hazel"], "cake":["chocolate guinness cake", "carrot cake"]}
var workerCredits = 0
var currency:int = 5000
var resourceCount = {"Orange":0, "Apple":0,"Lemon":0,"Lime":0,"Pear":0,"Strawberry":0,"Raspberry":0}
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
		GlobalInventory.exp+=amount
	else:
		resourceCount[str(resource)]=amount
		GlobalInventory.exp+=amount
		return false
	
func subtractResource(resource, amount):
	if resource not in resourceCount:
		resourceCount[resource] = 0
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

func addEXP(amount):
	exp+=amount
	if exp >= expProgression:
		exp -= expProgression
		level+=1
