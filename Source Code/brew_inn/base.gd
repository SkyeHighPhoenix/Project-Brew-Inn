extends Node3D
var exterior

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exterior = $ExteriorWorld

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if Input.is_action_just_pressed("enter"):
		EnteredTavern()
		print("enter")
	elif Input.is_action_just_pressed("exit"):
		ExitedTavern()
		print("exit")

func EnteredTavern():
	remove_child($ExteriorWorld)
	var interior = preload("res://InteriorScenes/tavernInterior.tscn")
	var interiorInstance = interior.instantiate()
	add_child(interiorInstance)

func ExitedTavern():
	add_child(exterior)
	remove_child($TavernInterior)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
