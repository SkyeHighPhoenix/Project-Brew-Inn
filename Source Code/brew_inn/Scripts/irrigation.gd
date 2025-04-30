extends Node2D
signal setTile(onSet, onMap)
signal checkNeigbors(location)
var tilePosition = Vector2i() # liles main tile position
var tileType = ""
var fillLevel = 0
var adjascentTiles = []
var connectableTiles = []
var neigbors = []
var connected = []
var isWell = false
const tilemapLocations = {"irwell":[Vector2i(6,3)],"irjunction":[Vector2i(5,2),Vector2i(4,3)],
 "irbend":[Vector2i(5,1),Vector2i(4,2)], "irstraight":[Vector2i(3,0)]}
const tileConnections = {"irwell":[true,true,true,true], "irjunction":[true,true,true,false],
"irbend":[false,false,true,true],"irstraight":[true,false,true,false]}

# Called when the node enters the scene tree for the first time.
func createBuilding(buildingType:String, coordinates:Vector2i, size:Vector2i, connectedTiles:Array, placingRotation:int):
	tileType = buildingType
	tilePosition = coordinates
	neigbors = [tilePosition+Vector2i(1,0), tilePosition+Vector2i(0,-1), 
	tilePosition+Vector2i(-1,0),tilePosition+Vector2i(0,1)]
	var nonRotConnections = tileConnections[buildingType].duplicate()
	for i in range(placingRotation):
		nonRotConnections.push_back(nonRotConnections.pop_front())
	connectableTiles = nonRotConnections
	print(connectableTiles)
	print(adjascentTiles)
	setTile.emit(tilemapLocations[tileType][0], tilePosition)
	checkInOut()
	pass

func setFill(fillNumber):
	fillLevel = fillNumber

func checkInOut(visited = []):
	visited.append(self)
	checkNeigbors.emit(self)
	var highestFill = 0
	for i in adjascentTiles:
		if i.tileType in tilemapLocations:
			if i.tilePosition in neigbors:
				var index = neigbors.find(i.tilePosition)
				if connectableTiles[index] and i.connectableTiles[index-2]:
					connected.append(i)
					if i.fillLevel > fillLevel +1:
						setFill(i.fillLevel-1)
					else:
						if len(visited)<11 and i not in visited:
							i.checkInOut(visited)
					if i.fillLevel > highestFill:
						highestFill == i.fillLevel
	if highestFill < fillLevel-1:
		if highestFill != 0:
			setFill(highestFill)
		else:
			setFill(0)
		visited.pop_back()
		checkInOut(visited)
	
	print(fillLevel, self)
