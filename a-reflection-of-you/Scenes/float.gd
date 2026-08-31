extends Node2D

@export var variation_amount := 10.0
@export var cycle := 2.0

var start_y : float = 0.0
var time_passed : float = 0.0

func _ready() -> void:
	start_y = position.y
	time_passed = randf_range(0, PI/2)

func _process(delta: float) -> void:
	time_passed += delta
	position.y = start_y + sin(time_passed * cycle) * variation_amount
