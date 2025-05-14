extends Camera2D
const zoomSpeed = 0.1
const borders = 500
var tileSize = 128


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		position -= event.relative/zoom
		restrictBorders()
		print(position)
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('ScrollUp'):
			if zoom.x <= 10:
				zoom *= 1+zoomSpeed
		elif Input.is_action_just_pressed("ScrollDown"):
			if zoom.x >= 0.1:
				zoom *= 1-zoomSpeed

func restrictBorders():
	var actualBorderX = (borders*tileSize)-(get_viewport_rect().size.x/2)/zoom.x
	var actualBorderY = (borders*tileSize)-(get_viewport_rect().size.y/2)/zoom.y
	print(actualBorderX)
	if position.x > actualBorderX:
		position.x = actualBorderX
	elif position.x < actualBorderX*-1:
		position.x = actualBorderX*-1
	if position.y > actualBorderY:
		position.y = actualBorderY
	elif position.y < actualBorderY*-1:
		position.y = actualBorderY*-1
