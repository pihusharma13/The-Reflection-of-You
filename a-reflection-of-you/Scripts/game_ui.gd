extends Control

@onready var win_screen : Control = $CanvasLayer/WinScreen
@onready var end_screen : Control = $CanvasLayer/EndScreen
@onready var timer_label : Label = $CanvasLayer/ColorRect/Label
@export var finish_line : Area2D

func _ready() -> void:
	get_tree().paused = false
	finish_line.player_finish.connect(_on_player_finished)
	
	win_screen.visible = false
	end_screen.visible = false

func pause() -> void:
	get_tree().paused = true

func _on_player_finished() -> void:
	win_screen.desc_label.text = "You finished with " + timer_label.text + " seconds remaining!"
	win_screen.visible = true
	timer_label.visible = false
	pause()

func _on_timer_timeout() -> void:
	end_screen.visible = true
	timer_label.visible = false
	pause()
