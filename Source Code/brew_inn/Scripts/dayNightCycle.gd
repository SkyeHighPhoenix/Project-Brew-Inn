extends CanvasModulate

const minsPerDay = 1440
const minsPerHour = 60
const minuteDuration = (2 * PI) / minsPerDay

var time = 0.0	

@export var gradient:GradientTexture1D
@export var timeSpeed = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * minuteDuration * timeSpeed;
	var value = (sin(time-0.5*PI) + 1.0) / 2.0
	print(time)
	print(value)
	self.color = gradient.gradient.sample(value)
	
