extends Node2D
var tilePosition = Vector2i() # liles main tile position
var tileSize = Vector2i() # 0,0 is a 1 by 1
var type = ""
var globalIrrigation = false
var storageBox = null

var connections = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func createBuilding(buildingType:String, coordinates:Vector2i, tileSize:Vector2i):
	type = buildingType
	tilePosition = coordinates
	pass

func checkOutputs(coordsIn):
	# take block
	# check if it matches an input or output on my one
	# add to inputs and outputs respectively
	pass
	
