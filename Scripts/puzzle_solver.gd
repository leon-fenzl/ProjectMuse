extends Node
class_name PuzzleSolver
@export var locks:Array[Area3D]
@export var vitoria : AudioStream
@export var targetInteractableRef : NodePath
@onready var targetInteractable = get_node(targetInteractableRef)
var solution : int
var solved : bool = false
var index : int = 0

func SumpUp():
	if solution>= 0 and solution<=locks.size():
		solution += 1
	if solution >= locks.size() and solved != true:
		solved = true
		targetInteractable.newState = Utilities.ITEM_STATE.ACTIVE
		targetInteractable.Interaction()
func SumpDown():
	if solution>= 0 and solution<=locks.size():
		solution -= 1
	if solution <= locks.size()-1 and solved != false:
		solved = false
		targetInteractable.newState = Utilities.ITEM_STATE.NOT_ACTIVE
		targetInteractable.Interaction()
