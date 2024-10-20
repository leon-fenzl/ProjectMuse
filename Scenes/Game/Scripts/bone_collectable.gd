extends Area3D

var bonesMng

func _ready():
	bonesMng = get_node("%BonesManager")

func _on_body_entered(body: Node3D) -> void:
	##Check if is Player
	if body.get_node("%Player"):
		bonesMng.GetBone()
		get_node("MeshOsso").queue_free()
		##tocar audio
