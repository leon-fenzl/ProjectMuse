extends Area3D

func _on_body_entered(body: Node3D) -> void:
	##Check if is Player
	if body.get_node("%Player"):
		print(body)
