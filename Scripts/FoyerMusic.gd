extends AudioStreamPlayer3D

@onready var audio = $"."

var chosenInt: int = 0
var restrictedArea = false

var array = ["res://Sounds/BGSounds/2 Game Play - Magnus Games Audio.wav","res://Sounds/BGSounds/3 Game Play - Magnus Games Audio.wav", "res://Sounds/BGSounds/Fase 1 - Primeiro Quadro - 2.wav"]
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	chosenInt = rng.randi_range(0, 1)
	audio.stream = load(array[chosenInt])
	audio.play()

func _physics_process(delta: float) -> void:
	if restrictedArea == true:
		if !audio.playing:
			audio.stream = load(array[2])
			audio.play()
	else:
		if !audio.playing:
			var x = chosenInt
			while chosenInt == x:
				rng.randomize()
				chosenInt = rng.randi_range(0, 1)
			audio.stream = load(array[chosenInt])
			audio.play()
