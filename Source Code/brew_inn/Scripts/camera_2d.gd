extends Camera2D
const zoomSpeed = 0.1
const borders = 500
var tileSize = 128

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var originButton = get_tree().get_root().get_node("/root/Base/ExteriorWorld/CanvasLayer/UiOverlay/originButton")
	originButton.pressed.connect(returnToOrigin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		position -= event.relative/zoom
		restrictBorders()
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('ScrollUp'):
			if zoom.x <= 10:
				zoom *= 1+zoomSpeed
		elif Input.is_action_just_pressed("ScrollDown"):
			if zoom.x >= 0.1:
				zoom *= 1-zoomSpeed
		restrictBorders()

func restrictBorders():
	var actualBorderX = (borders*tileSize)-(get_viewport_rect().size.x/2)/zoom.x
	var actualBorderY = (borders*tileSize)-(get_viewport_rect().size.y/2)/zoom.y
	var actualBorderYDown = (20*tileSize)-(get_viewport_rect().size.y/2)/zoom.y
	if position.x > actualBorderX:
		position.x = actualBorderX
	elif position.x < actualBorderX*-1:
		position.x = actualBorderX*-1
	if position.y > actualBorderYDown:
		position.y = actualBorderYDown
	elif position.y < actualBorderY*-1:
		position.y = actualBorderY*-1

func returnToOrigin():
	position = Vector2(0,0)
	zoom = Vector2(0.555,0.555)
