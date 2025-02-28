class_name PuzzleSystem
extends Area3D
@export var puzzleCamera : Camera3D
@export var locks:Array[Area3D]
@export var vitoria : AudioStreamPlayer
@export var targetInteractable : Node
var solution : int
var solved : bool = false
var index : int = 0
var player : Node
@export var lable : Label
func _ready() -> void:
	player = PlayerBehaviour.playerRef
func _on_body_entered(body: Node3D) -> void:
	if body == player:
		Focus()
		body.paintCam = puzzleCamera
		body.onFocus = true
func _on_body_exited(body: Node3D) -> void:
	if body == player:
		Unfocus()
		body.paintCam = null
		body.onFocus = false
func  Focus():
	lable.visible = !lable.visible
func Unfocus():
	lable.visible = !lable.visible
func SumpUp():
	if solution>= 0 and solution <= locks.size():
		solution += 1
	if solution >= locks.size() and solved != true:
		solved = true
		if targetInteractable != null:
			targetInteractable.newState = Utilities.ITEM_STATE.ACTIVE
			targetInteractable.Interaction()
			vitoria.play()
func SumpDown():
	if solution>= 0 and solution<=locks.size():
		solution -= 1
	if solution <= locks.size()-1 and solved != false:
		solved = false
		if targetInteractable != null:
			targetInteractable.newState = Utilities.ITEM_STATE.NOT_ACTIVE
			targetInteractable.Interaction()
