extends Node3D
var exterior
var inside = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exterior = $ExteriorWorld
	var gridTest = get_node("ExteriorWorld/GridTest")
	gridTest.tileTapped.connect(handleStructureInteractions)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if Input.is_action_just_pressed("enter")&&inside:
		EnteredTavern()
		print("enter")
	elif Input.is_action_just_pressed("exit")&&!inside:
		ExitedTavern()
		print("exit")

func EnteredTavern():
	inside = true
	remove_child($ExteriorWorld)
	var interior = preload("res://InteriorScenes/tavernInterior.tscn")
	var interiorInstance = interior.instantiate()
	add_child(interiorInstance)

func ExitedTavern():
	inside = false
	add_child(exterior)
	remove_child($TavernInterior)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func handleStructureInteractions(isPlaced, structure):
	if !isPlaced:
		match structure:
			"tavern":
				EnteredTavern()
			"warehouse":
				$ExteriorWorld/CanvasLayer/UiWarehouse.show()
			"shop":
				$ExteriorWorld/CanvasLayer/UiShop.show()
	else:
		pass
