extends Node2D
var previousCoords = Vector2i.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setCoords(coords:Vector2i, sourceId:int, atlasCoords:Vector2i, altTile:int):
	$PlacingLayer.set_cell(coords,sourceId,atlasCoords,altTile)
	if previousCoords != Vector2i.ZERO and coords != previousCoords:
		$PlacingLayer.set_cell(previousCoords, -1, Vector2i(-1,-1),-1)
	previousCoords = coords

func getTileSize(coords:Vector2i):
	return $PlacingLayer.tile_set.get_source(0).get_tile_size_in_atlas(Vector2i(2,0))
	pass
	
func clearPlacing():
	$PlacingLayer.set_cell(previousCoords, -1, Vector2i(-1,-1),-1)
	previousCoords = Vector2i.ZERO
	
