extends Node2D
const category = "irrigation"
signal setTile(onSet, onMap)
signal checkNeigbors(location)
signal setIrrigation(vectors)
var tilePosition = Vector2i() # liles main tile position
var tileType = ""
var fillLevel = 0
var adjascentTiles = []
var connectableTiles = []
var neigbors = []
var connected = []
var placeRot = 0
var isWell = false
const tilemapLocations = {"irwell":[Vector2i(6,3)],
"irjunction":[Vector2i(5,2),Vector2i(3,3),Vector2i(5,3),Vector2i(4,3)],
 "irbend":[Vector2i(5,1),Vector2i(3,2),Vector2i(5,0),Vector2i(4,2)], 
"irstraight":[Vector2i(4,1),Vector2i(3,1),Vector2i(4,0), Vector2i(3,0)]}
const tileConnections = {"irwell":[true,true,true,true], "irjunction":[true,true,true,false],
"irbend":[false,false,true,true],"irstraight":[true,false,true,false]}
const valueToTexture = {10:3, 9:3, 8:3,7:3,6:3,5:2,4:2,3:2,2:1,1:1,0:0}

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
	setTile.emit(tilemapLocations[tileType][0], tilePosition, placingRotation)
	placeRot = placingRotation
	if tileType == "irwell":
		fillLevel = 11
		isWell = true
		var Irrigated = []
		for i in range(5):
			for x in range(5):
				Irrigated.append(tilePosition+Vector2i(i-2,x-2))
		setIrrigation.emit(Irrigated)
	checkInOut()
	pass

func setFill(fillNumber):
	if not isWell:
		fillLevel = fillNumber
		print(placeRot, "thisRotation")
		setTile.emit(tilemapLocations[tileType][valueToTexture[fillLevel]], tilePosition, placeRot)
		if fillLevel > 0:
			var Irrigated = []
			for i in range(5):
				for x in range(5):
					Irrigated.append(tilePosition+Vector2i(i-2,x-2))
			setIrrigation.emit(Irrigated)
	

func checkInOut(visited = []):
	print(tileType, " this is me and visited is ", visited)
	visited.append(self)
	checkNeigbors.emit(self)
	var highestFill = 0
	for i in adjascentTiles:
		if i.tileType in tilemapLocations:
			if i.tilePosition in neigbors:
				var index = neigbors.find(i.tilePosition)
				if connectableTiles[index] and i.connectableTiles[index-2]:
					if i not in connected:
						connected.append(i)
					if i.fillLevel > fillLevel +1:
						setFill(i.fillLevel-1)
					if i.fillLevel > highestFill:
						highestFill == i.fillLevel
	for i in connected:
		if len(visited)<11 and i not in visited and i.fillLevel < fillLevel-1:
			i.checkInOut(visited)
