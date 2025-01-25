class_name PlayerSceneChanger
extends Area3D
@export var currentScene := Utilities.CHANGEDIRECTION.HUB
func _on_body_entered(body: Node3D) -> void:
	match currentScene:
		Utilities.CHANGEDIRECTION.HUB:
			SceneLoader.selfRef.Load_Scene(Utilities.museum)
			currentScene = Utilities.CHANGEDIRECTION.P_ONE
		Utilities.CHANGEDIRECTION.P_ONE:
			SceneLoader.selfRef.Load_Scene(Utilities.paintingOne)
			currentScene = Utilities.CHANGEDIRECTION.HUB
