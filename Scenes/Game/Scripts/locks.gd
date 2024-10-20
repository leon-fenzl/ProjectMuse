extends Area3D
@onready var check := false
@export var lockValue :int
func _on_body_entered(body: Node3D) -> void:
	if body.keyValue == lockValue:
		check = true
		print(check)
func _on_body_exited(body: Node3D) -> void:
	if body.keyValue == lockValue:
		check = false
