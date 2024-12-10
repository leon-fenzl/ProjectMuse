extends Area3D
class_name Lock
@onready var check := false
@export var targetPiece : Node
@export var solverRef : NodePath
@onready var solver = get_node(solverRef)
func _on_body_entered(body: Node3D) -> void:
	if body == targetPiece:
		#check = true
		solver.SumpUp()
func _on_body_exited(body: Node3D) -> void:
	if body == targetPiece:
		print("hi")
		#check = false
		solver.SumpDown()
