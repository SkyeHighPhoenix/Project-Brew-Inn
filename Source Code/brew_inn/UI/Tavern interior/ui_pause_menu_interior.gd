extends Control

var paused = false

func pause():
	show()
	paused = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func resume():
	hide()
	paused = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

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
