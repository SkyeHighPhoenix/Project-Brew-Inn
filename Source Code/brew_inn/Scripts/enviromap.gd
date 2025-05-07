extends Node2D

# will allow for the creation and expansion of the visual layer of the world map
var random = RandomNumberGenerator.new()
var tileweights = PackedFloat32Array([0.2,1,1,10])
var grassTiles = [Vector2i(1,2),Vector2i(2,2),Vector2i(1,1),Vector2i(2,1)]
var outsideSize = Vector2i(1000,1000)

var borderWeights = PackedFloat32Array([1,4])
var grassBorder = [[Vector2i(3,1),Vector2i(3,2)],[Vector2i(2,0),Vector2i(1,0)],[Vector2i(0,1), Vector2i(0,2)],[Vector2i(2,3),Vector2i(1,3)]]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(outsideSize.x):
		for y in range(outsideSize.y):
			var tile = grassTiles[random.rand_weighted(tileweights)]
			$Layer1.set_cell(Vector2i(-x,-y),1,tile,0)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
