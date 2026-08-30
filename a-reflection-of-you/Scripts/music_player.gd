
extends AudioStreamPlayer

@onready var main_music : AudioStreamWAV = preload("res://Assets/Audio/Mainmenunya!.wav")
@onready var game_music : AudioStreamWAV = preload("res://Assets/Audio/1stpartRunrunrun!.wav")

func play_main_music() -> void:
	if stream == main_music:
		print("Trying to play same music")
		return
	
	stream = main_music
	play()

func play_game_music() -> void:
	if stream == game_music:
		print("Trying to play same music")
		return
	
	stream = game_music
	play()

func _ready():
	finished.connect(_on_finished)

func _on_finished():
	play()
