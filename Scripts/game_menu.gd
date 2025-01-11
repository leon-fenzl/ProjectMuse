extends CanvasLayer

@onready var audio_stream_player: AudioStreamPlayer = $"../AudioManager/AudioStreamPlayer"
const menu_pause = preload("res://Sounds/BGSounds/Menu&Pause.wav")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _input(event):
	if Input.is_action_just_pressed("Escape"):
		get_tree().paused = !get_tree().paused 
		self.visible = get_tree().paused
	if get_tree().paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if !audio_stream_player.playing:
			audio_stream_player.play()
	elif get_tree().paused == false:
		audio_stream_player.stop()
#tratlalalalalalala
