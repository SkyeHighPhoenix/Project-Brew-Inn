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
	add_child($TavernInterior)

func ExitedTavern():
	add_child(exterior)
	remove_child($TavernInterior)
