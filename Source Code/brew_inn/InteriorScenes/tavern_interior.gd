extends Node3D
var camera
var emptyCup
var fullCup
var bottle
var servedRecently
signal exit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = $Player/Camera3D
	emptyCup = $Player/EmptyMug
	fullCup = $Player/FullMug
	bottle = $Player/Bottle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * 1000

			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.new()
			query.from = from
			query.to = to
			query.collision_mask = 1<<2

			var result = space_state.intersect_ray(query)

			if result:
				var clicked_object = result.collider
				if clicked_object:
					print("Clicked on:", clicked_object.name)
					clickedArea(clicked_object.name)

func clickedArea(area):
	match area:
		"Exit":
			exit.emit()
		"ServeSpace":
			if !servedRecently:
				servedRecently = true
				if emptyCup.visible:
					emptyCup.hide()
				elif fullCup.visible:
					fullCup.hide()
					GlobalInventory.currency+=5
					GlobalInventory.addEXP(10)
					$servedMug.show()
					$Timer.start()
				elif bottle.visible:
					bottle.hide()
					GlobalInventory.currency+=10
					GlobalInventory.addEXP(15)
					$servedBottle.show()
					$Timer.start()
		"Cups":
			if !emptyCup.visible &&!fullCup.visible&&!bottle.visible:
				emptyCup.show()
		"Bottles":
			if !emptyCup.visible &&!fullCup.visible&&!bottle.visible:
				bottle.show()
		"Taps":
			if emptyCup.visible:
				emptyCup.hide()
				fullCup.show()


func _on_timer_timeout() -> void:
	$servedMug.hide()
	$servedBottle.hide()
	servedRecently = false
