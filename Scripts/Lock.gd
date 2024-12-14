extends Area3D
class_name Lock
@onready var check := false
@export var targetPiece : Pieces
@export var solverRef : PuzzleSystem
func _on_body_entered(body: Node3D) -> void:
	if body == targetPiece:
		#check = true
		solverRef.SumpUp()
func _on_body_exited(body: Node3D) -> void:
	if body == targetPiece:
		#check = false
		solverRef.SumpDown()
