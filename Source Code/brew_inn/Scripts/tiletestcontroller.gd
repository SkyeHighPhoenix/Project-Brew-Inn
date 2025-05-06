extends Node2D
signal setTile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				print("1")
				setTile.emit("storage", "storage")
			KEY_2:
				print("2")
				setTile.emit("orchardLemon","standardFarm")
			
			KEY_3:
				print("3")
				setTile.emit("cropPlot", "cropPlot")
			KEY_4:
				print("4")
				setTile.emit("herbGarden", "herbGarden")
			KEY_5:
				print("5")
				setTile.emit("irbend", "irrigation")
			KEY_6:
				print("6")
				setTile.emit("irwell", "irrigation")
			KEY_7:
				print("7")
				setTile.emit("irstraight", "irrigation")
			KEY_8:
				print("8")
				setTile.emit("irjunction", "irrigation")
				
