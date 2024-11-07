extends Node

@export var totalBones : int = 3
@export var actualBonesQuantity : int = 0

@export var coletavel : AudioStream
@export var vitoria : AudioStream

func GetBone():
	##tocar audio
	get_node("AudioStreamPlayer").stream = load("res://Sounds/SoundEffects/Vitória Osso.wav")
	get_node("AudioStreamPlayer").play()
	
	print("Pegou um osso")
	actualBonesQuantity += 1
	if actualBonesQuantity >= totalBones:
		CollectedAllBones()

func CollectedAllBones():
	print("Pegou todos os ossos")
	##fim do jogo
	##tocar audio
	get_node("AudioStreamPlayer").stream = load("res://Sounds/SoundEffects/Vitória Level.wav")
	get_node("AudioStreamPlayer").play()
