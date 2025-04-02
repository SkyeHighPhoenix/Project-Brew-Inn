extends Node2D
var tilePosition = Vector2i() # liles main tile position
var tileType = ""
var
# Called when the node enters the scene tree for the first time.
func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, irrigationStatus:bool, connectedTiles:Array):
	tileType = buildingType
	tilePosition = coordinates
	pass
