extends Control
var paused = false

func pause():
	show()
	paused = true
	get_tree().paused = true
	
func resume():
	hide()
	paused = false
	get_tree().paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	var pauseButton = get_tree().get_root().get_node("/root/Base/ExteriorWorld/CanvasLayer/UiOverlay/pauseButton")
	pauseButton.pressed.connect(pause)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if Input.is_action_just_pressed("pause"):
		if paused == false:
			pause()
		else:
			resume()


func _on_back_button_pressed() -> void:
	resume()


func _on_save_and_quit_button_pressed() -> void:
	get_tree().quit()
