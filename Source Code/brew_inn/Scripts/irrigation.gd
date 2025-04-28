extends Node2D
signal setTile(onSet, onMap)
var tilePosition = Vector2i() # liles main tile position
var tileType = ""
var fillLevel = 0
var adjascentTiles = []
var isWell = false
const tilemapLocations = {"irwell":Vector2i(6,3),"irjunction":Vector2i(4,3), "irbend":Vector2i(4,2), "irstraight":Vector2i(3,0)}
const tileConnections = {"irwell":[true,true,true,true], "irjunction":[true,true,true,false],"irbend":[false,false,true,true],"irstraight":[true,false,true,false]}

# Called when the node enters the scene tree for the first time.
func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, connectedTiles:Array, placingRotation:int):
	tileType = buildingType
	tilePosition = coordinates
	var nonRotConnections = tileConnections[buildingType]
	for i in range(placingRotation):
		var last = nonRotConnections[3]
		print(last)
		nonRotConnections.remove_at(3)
		print(nonRotConnections)
	print(nonRotConnections)
		
	
	pass
