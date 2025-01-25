class_name PlayerSpawner
extends Marker3D
@onready var playerOnFile:=preload("res://Scenes/Game/Player/Player.tscn")
var instance:Node= null
func _ready() -> void:
	SpawnPlayer()
func SpawnPlayer():
	if instance == null:
		instance = playerOnFile.instantiate()
		instance.position = position
		get_parent().add_child.call_deferred(instance)
	Utilities.GetPlayerNode(instance)
	instance = null
