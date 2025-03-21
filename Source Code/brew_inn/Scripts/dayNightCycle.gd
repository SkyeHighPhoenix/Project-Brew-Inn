extends CanvasModulate

var tick = 3000
@export var gradient:GradientTexture1D

func _ready() -> void:
	GlobalTick.tickIncreased.connect(tickIncrease)
	
func _process(delta: float) -> void:
	var value = (sin((tick*(2*PI)/(24*1200))-0.5*PI) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	
func tickIncrease():
	tick += 1
	
