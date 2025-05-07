extends Node2D

signal freshIrrigation(tiles)

const tileTypeDict = {
	"storage":[Vector2i(1,1)], 
	"cropPlot":[Vector2i(0,1)],
	"greenhouse":Vector2i(0,2),
	"orchardLemon":[Vector2i(3,4)], 
	"berryBushes":[Vector2i(0,5)], 
	"herbGarden":[Vector2i(0,6)],
	"irwell":[Vector2i(6,3)],
	"irjunction":[Vector2i(4,3)], 
	"irbend":[Vector2i(4,2)], 
	"irstraight":[Vector2i(3,0)],
	"bottlingUnit":[Vector2i(2,7)],
	"carbonator":[Vector2i(3,6)],
	"dehydrator":[Vector2i(6,6)],
	"fermenter":[Vector2i(4,7)], 
	"industrialMixer":[Vector2i(0,8)], 
	"juicer":[Vector2i(6,4)], 
	"washer":[Vector2i(3,8)], 
	"waterProcessingUnit":[Vector2i(6,8)]}
var currentlyPlacing = true
var dictionaryOfTiles = {} # for each populated tile in the ObjectLayer, format {mapIndex Vector2i():Building String}
var dictionaryOfIrrigation = {} # each tile will have a number value, representing how many irrigation pipes are irrigating it
# need to have a bool in all farm tiles that tells when it's globally irrigated
# need a way of referring to the actual object, maybe populate the dict with objects instead?
#//order in which the tiles will be checked to connect nodes
const checkOrder = [Vector2i(1,0),Vector2i(0,-1),Vector2i(-1,0), Vector2i(0,1)] 
const rotatableTiles = ["irrigation"]

var isPlacing = true
var placingTile = "storage"
var placingTileType = "storage"
var placingRotation = 0
var rotationLocked = false
var NodeScale =0.555
var viewportSize = null

var testingInterface = null
var testingInstance = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewportSize = get_viewport().size
	$Camera2D.zoom *= $Camera2D.zoom*NodeScale
	testingInterface = load("res://TileScenes/tiletestcontroller.tscn")
	testingInstance = testingInterface.instantiate()
	add_child(testingInstance)
	testingInstance.setTile.connect(setPlacingTile)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getMouseToCoords(eventCoords): #something appears to be off with where the tilemap thinks the mouse is
	var newcoords = Vector2(eventCoords)-Vector2(viewportSize/2)
	newcoords *= Vector2(NodeScale/$Camera2D.zoom.x,NodeScale/$Camera2D.zoom.y)
	newcoords += Vector2($Camera2D.position*NodeScale)
	return Vector2i(newcoords)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and isPlacing:
		if placingTile != null:
			setPlacingTexture(checkCoords(getMouseToCoords(event.position))[0], placingTile)
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed == false:
			if placingTile != null:
				placeTile(getMouseToCoords(event.position))
	if event is InputEventKey:
		print(rotationLocked)
		if OS.get_keycode_string(event.keycode) == 'R' and placingTileType in rotatableTiles:
			if event.is_action_pressed:
				if not rotationLocked:
					if placingRotation != 3:
						placingRotation +=1
					else:
						placingRotation = 0
					setPlacingTexture(checkCoords(getMouseToCoords(get_viewport().get_mouse_position()))[0], placingTile)
					rotationLocked = true
				elif event.is_action_released:
					rotationLocked = false

func setPlacingTile(tile, tileType):
	placingTile = tile
	placingTileType = tileType
	placingRotation = 0
	if tile == null:
		$PlacingObject.clearPlacing()
	setPlacingTexture(checkCoords(getMouseToCoords(get_viewport().get_mouse_position()))[0], placingTile)

func checkCoords(mousePosition:Vector2):
	var mapCoords = $TileMap/Layer1.local_to_map(mousePosition/NodeScale)
	var globalCoords = $TileMap/Layer1.map_to_local(mapCoords)
	return [mapCoords,globalCoords]
	pass

func setPlacingTexture(Coords:Vector2i, Placing:String):
	$PlacingObject.setCoords(Coords,0,tileTypeDict[Placing][0],placingRotation)
	pass

func placeTile(coordinates):
	var mapIndex = checkCoords(coordinates)[0]
	if checkTileValid(mapIndex):
		var connectedTiles = checkConnected(mapIndex)
		match placingTileType:
			
			"storage":
				var tileToPlace = load("res://TileScenes/storageTile.tscn")
				var tileInstance = tileToPlace.instantiate()
				var tileSize = $PlacingObject.getTileSize(tileTypeDict[placingTile][0])
				tileInstance.setTile.connect(setTileAt.bind())
				tileInstance.createBuilding(placingTile, mapIndex, tileSize,connectedTiles)
				for i in range(tileSize.x):
					for j in range(tileSize.y):
						dictionaryOfTiles[mapIndex - Vector2i(i,j)] = tileInstance
				pass
				
			"standardFarm":
				placeTypeFarm(mapIndex,connectedTiles,"res://TileScenes/standard_farm.tscn")
				
			"herbGarden":
				placeTypeFarm(mapIndex,connectedTiles,"res://TileScenes/herb_garden.tscn")
				
			"cropPlot":
				placeTypeFarm(mapIndex,connectedTiles,"res://TileScenes/crop_plots.tscn")
			
			"irrigation":
				var tileToPlace = load("res://TileScenes/Irrigation.tscn")
				var tileInstance = tileToPlace.instantiate()
				var tileSize = $PlacingObject.getTileSize(tileTypeDict[placingTile][0])
				tileInstance.setTile.connect(setTileAt.bind())
				tileInstance.checkNeigbors.connect(neigbors.bind())
				tileInstance.setIrrigation.connect(setIrrigation.bind())
				for i in range(tileSize.x):
					for j in range(tileSize.y):
						dictionaryOfTiles[mapIndex - Vector2i(i,j)] = tileInstance
				tileInstance.createBuilding(placingTile, mapIndex, tileSize,connectedTiles, placingRotation)
			"productionMachine":
				var tileToPlace = load("res://TileScenes/production_machine.tscn")
				var tileInstance = tileToPlace.instantiate()
				var tileSize = $PlacingObject.getTileSize(tileTypeDict[placingTile][0])
				tileInstance.setTileAt.connect(setTileAt.bind())
				for i in range(tileSize.x):
					for j in range(tileSize.y):
						dictionaryOfTiles[mapIndex - Vector2i(i,j)] = tileInstance
				tileInstance.createBuilding(placingTile, mapIndex, tileSize,connectedTiles)
				
				
	pass

func placeTypeFarm(mapIndex:Vector2i, connectedTiles:Array, placing:String):
	var tileToPlace = load(placing)
	var tileInstance = tileToPlace.instantiate()
	var tileSize = $PlacingObject.getTileSize(tileTypeDict[placingTile][0])
	var irrigated = false if mapIndex not in dictionaryOfIrrigation else true # need to adjust for larger tiles
	for i in range(tileSize.x):
		for j in range(tileSize.y):
			dictionaryOfTiles[mapIndex - Vector2i(i,j)] = tileInstance
			if mapIndex - Vector2i(i,j) in dictionaryOfIrrigation:
				irrigated = true
	tileInstance.setTileAt.connect(setTileAt.bind())
	freshIrrigation.connect(tileInstance.catchIrrigation.bind())
	tileInstance.createBuilding(placingTile, mapIndex, tileSize, irrigated,connectedTiles)

func setIrrigation(coordinates):
	for i in coordinates:
		if i not in dictionaryOfIrrigation:
			dictionaryOfIrrigation[i] = 1
		else:
			dictionaryOfIrrigation[i] += 1
	freshIrrigation.emit(coordinates)

func setTileAt(onSet, onMap, placeRotation = null): # linked to signals
	var currentrotation = $PlacingObject.getRotation(placingRotation if placeRotation == null else placeRotation)
	$TileMap/ObejctLayer.set_cell(onMap,0,onSet,currentrotation)
	pass

func checkTileValid(coordinates): # checks if a tile has been placed in region
	var tileSize = $PlacingObject.getTileSize(tileTypeDict[placingTile][0])
	var isValid = true
	for x in range(tileSize.x):
		for y in range(tileSize.y):
			if coordinates - Vector2i(x,y) in dictionaryOfTiles:
				isValid = false
	print(isValid)
	return isValid

func neigbors(tile):
	var coordinates = tile.tilePosition
	var tileConnectionList = []
	for i in checkOrder:
		var thisTile = coordinates + i
		if thisTile in dictionaryOfTiles:
			tileConnectionList.append(dictionaryOfTiles[thisTile])
	tile.adjascentTiles = tileConnectionList

func checkConnected(coordinates:Vector2i): # checks what tiles are placed relative to the placing tile
	var tileConnectionList = []
	for i in checkOrder:
		var thisTile = coordinates + i
		if thisTile in dictionaryOfTiles:
			tileConnectionList.append(dictionaryOfTiles[thisTile])
	return tileConnectionList
