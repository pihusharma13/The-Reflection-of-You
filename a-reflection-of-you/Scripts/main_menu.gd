extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false

func _on_start_button_pressed() -> void:
	print("Start Pressed")
	$Button.disabled = true
	$"Button/Button Animation".play("start button")
	await $"Button/Button Animation".animation_finished
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
