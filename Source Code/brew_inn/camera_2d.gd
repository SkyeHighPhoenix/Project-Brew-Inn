extends Camera2D
const zoomSpeed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		position -= event.relative/zoom
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('ScrollUp'):
			zoom *= 1+zoomSpeed
		elif Input.is_action_just_pressed("ScrollDown"):
			zoom *= 1-zoomSpeed
