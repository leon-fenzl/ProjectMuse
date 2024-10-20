extends Node

@export var totalBones : int = 3
@export var actualBonesQuantity : int = 0

func GetBone():
	##tocar audio
	##get_node("AudioStreamPlayer").Play()
	
	print("Pegou um osso")
	actualBonesQuantity += 1
	if actualBonesQuantity >= totalBones:
		CollectedAllBones()

func CollectedAllBones():
	print("Pegou todos os ossos")
	##fim do jogo
