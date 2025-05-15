extends Node3D
var exterior
var inside = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exterior = $ExteriorWorld
	var gridTest = get_node("ExteriorWorld/GridTest")
	gridTest.tileTapped.connect(handleStructureInteractions)
	#exterior.get_node("UiShop")
	get_node("ExteriorWorld/CanvasLayer/UiShop").setTile.connect(gridTest.setPlacingTile)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if Input.is_action_just_pressed("enter")&&!inside:
		EnteredTavern()
		print("enter")
	elif Input.is_action_just_pressed("exit")&&inside:
		ExitedTavern()
		print("exit")

func uiToggled():
	pass

func EnteredTavern():
	inside = true
	remove_child($ExteriorWorld)
	var interior = preload("res://InteriorScenes/tavernInterior.tscn")
	var interiorInstance = interior.instantiate()
	add_child(interiorInstance)
	$TavernInterior.exit.connect(ExitedTavern)

func ExitedTavern():
	inside = false
	add_child(exterior)
	remove_child($TavernInterior)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func handleStructureInteractions(isPlaced, structure):
	var ui
	if !isPlaced:
		match structure:
			"tavern":
				EnteredTavern()
			"warehouse":
				$ExteriorWorld/CanvasLayer/UiWarehouse.show()
			"shop":
				$ExteriorWorld/CanvasLayer/UiShop.show()
	else:
		match structure.category:
			"cropPlots":
				pass
			"storage":
				ui = preload("res://UI/External world/UI_farming_structure.tscn")
				var uiInstance = ui.instantiate()
				uiInstance.init(structure)
				$ExteriorWorld/CanvasLayer.add_child(uiInstance)
			"standardFarm":
				ui = preload("res://UI/External world/UI_farming_structure.tscn")
				var uiInstance = ui.instantiate()
				uiInstance.init(structure)
				$ExteriorWorld/CanvasLayer.add_child(uiInstance)
