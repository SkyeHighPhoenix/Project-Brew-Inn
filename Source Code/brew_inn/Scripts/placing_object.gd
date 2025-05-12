extends Node2D
var previousCoords = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getRotation(rotation):
	var test = 0
	match rotation:
		1:
			test |= $PlacingLayer.tile_set.get_source(0).TRANSFORM_FLIP_H
			test |= $PlacingLayer.tile_set.get_source(0).TRANSFORM_TRANSPOSE
		2: 
			test |= $PlacingLayer.tile_set.get_source(0).TRANSFORM_FLIP_V
			test |= $PlacingLayer.tile_set.get_source(0).TRANSFORM_FLIP_H
		3: 
			test |= $PlacingLayer.tile_set.get_source(0).TRANSFORM_FLIP_H
	return test
	

func setCoords(coords:Vector2i, sourceId:int, atlasCoords:Vector2i, altTile:int=0):
	var rotation = getRotation(altTile)
	$PlacingLayer.set_cell(coords,sourceId,atlasCoords,rotation)
	if previousCoords != null and coords != previousCoords:
		$PlacingLayer.set_cell(previousCoords, -1, Vector2i(-1,-1),-1)
	previousCoords = coords

func clear():
	$PlacingLayer.set_cell(previousCoords, -1, Vector2i(-1,-1),-1)
func getTileSize(coords:Vector2i):
	return $PlacingLayer.tile_set.get_source(0).get_tile_size_in_atlas(coords)
	pass
	
func clearPlacing():
	
	$PlacingLayer.set_cell(previousCoords, -1, Vector2i(-1,-1),-1)
	previousCoords = Vector2i.ZERO
