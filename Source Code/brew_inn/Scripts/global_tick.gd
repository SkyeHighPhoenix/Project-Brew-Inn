extends Node2D
var tick = 0 #unneccissary?
var time = 0
signal tickIncreased
signal timeIncreased(time)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time 


func _on_timer_timeout() -> void:
	tick+=1
	print("tick ", tick)
	tickIncreased.emit()
	if tick % (20*60) == 0:
		time+=1
		if time >= 24:
			time = 0
		print(time)
		timeIncreased.emit(time)
