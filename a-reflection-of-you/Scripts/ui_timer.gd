extends Label

@onready var timer : Timer = $Timer
var max_time : float

func _ready() -> void:
	max_time = timer.time_left

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "%.2f" % (timer.time_left)
	
	var ratio : float = timer.time_left / max_time
	self.modulate = Color.WHITE.lerp(Color.RED, 1.0 - ratio)
