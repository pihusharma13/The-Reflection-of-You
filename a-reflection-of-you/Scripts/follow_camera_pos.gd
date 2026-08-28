extends Node2D

@export var follow_x := true
@export var follow_y := true

var camera : Camera2D

func _ready() -> void:
	camera = get_viewport().get_camera_2d()


func _process(delta: float) -> void:
	if follow_x: global_position.x = camera.get_screen_center_position().x
	if follow_y: global_position.y = camera.get_screen_center_position().y
