extends Area3D

var bonesMng

func _ready():
	bonesMng = get_node("%BonesManager")

func _on_body_entered(body: Node3D) -> void:
	##Check if is Player
	if body.has_node("%Player"):
		GetBone()
		
func GetBone():
	bonesMng.GetBone()
	queue_free()
