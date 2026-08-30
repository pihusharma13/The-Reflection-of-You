extends Control

@onready var desc_label : Label = $Label2

func _on_button_pressed() -> void:
	print("MainMenu Pressed")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_button_2_pressed() -> void:
	print("Retry Pressed")
	get_tree().change_scene_to_file("res://Scenes/pilot_level.tscn")
