extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init(structureID):
	$StructureName.text = structureID.finalType


func _on_back_button_pressed() -> void:
	queue_free()
