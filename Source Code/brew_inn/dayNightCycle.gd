extends CanvasModulate
var time = 0.00

@export var gradient:GradientTexture1D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	var value = (sin(time - PI/2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	
