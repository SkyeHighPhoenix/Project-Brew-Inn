extends Node2D

const tileTypeDict = {"Distillery":[Vector2i(1,0)], "House":[Vector2i(0,0)], "test":[Vector2i(2,0)]}
var currentlyPlacing = true
var dictionaryOfTiles = {} # for each populated tile in the ObjectLayer, format {mapIndex Vector2i():Building String}
var dictionaryOfIrrigation = {} # each tile will have a number value, representing how many irrigation pipes are irrigating it
# need to have a bool in all farm tiles that tells when it's globally irrigated
# need a way of referring to the actual object, maybe populate the dict with objects instead?
var isPlacing = true
var placingTile = "test"
var placingTileType = "Farm"
var NodeScale = 0.555

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.zoom = $Camera2D.zoom*NodeScale
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and isPlacing:
		if placingTile != null:
			setPlacingTexture(checkCoords(event.position)[0], placingTile)
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed == false:
			if placingTile != null:
				placeTile(event.position)
			
func setPlacingTile(tile, tileType):
	placingTile = tile
	placingTileType = tileType
	if tile == null:
		$PlacingObject.clearPlacing()

func checkCoords(mousePosition:Vector2):
	var mapCoords = $TileMap/Layer1.local_to_map(mousePosition/NodeScale)
	var globalCoords = $TileMap/Layer1.map_to_local(mapCoords)
	return [mapCoords,globalCoords]
	pass

func setPlacingTexture(Coords:Vector2i, Placing:String):
	$PlacingObject.setCoords(Coords,0,tileTypeDict[Placing][0],0)
	
	pass

func placeTile(coordinates):
	var mapIndex = checkCoords(coordinates)[0]
	if mapIndex not in dictionaryOfTiles:
		placeTexture(mapIndex, placingTile)
		if placingTileType == "Farm":
			var tileToPlace = load("res://test_tile.tscn")
			var tileInstance = tileToPlace.instantiate()
			var tileSize = $PlacingObject.getTileSize(tileTypeDict[placingTile][0])
			tileInstance.createBuilding(placingTile, mapIndex, tileSize)
			dictionaryOfTiles[mapIndex] = tileInstance
			print(dictionaryOfTiles)
	pass

func placeTexture(Coords:Vector2i,Placing:String):
	
	$TileMap/ObejctLayer.set_cell(Coords,0,tileTypeDict[Placing][0],0)
	$PlacingObject.getTileSize(Vector2i(2,1))
	pass

func changePlacing(placing:String):
	pass
