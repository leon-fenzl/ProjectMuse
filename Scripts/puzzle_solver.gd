class_name PuzzleSolver 
extends StaticBody3D
@export var puzzleCamera : Node
@export var locks:Array[Area3D]
@export var vitoria : AudioStream
@export var targetInteractableRef : NodePath
@onready var targetInteractable = get_node(targetInteractableRef)
var solution : int
var solved : bool = false
var index : int = 0

func _physics_process(delta: float) -> void:
		match Utilities.gameMode:
			Utilities.GAMEMODE.PUZZLE:
				if puzzleCamera.current != false:
					puzzleCamera.current = false
			Utilities.GAMEMODE.PUZZLE:
				if puzzleCamera.current != true:
					puzzleCamera.current = true
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
