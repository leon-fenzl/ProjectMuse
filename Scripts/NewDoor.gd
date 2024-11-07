extends Interactable
class_name NewDoor
var state := Utilities.ITEM_STATE.NOT_ACTIVE
var newState : Utilities.ITEM_STATE
@export var openPos:=Vector3.ZERO
var closedPos := Vector3.ZERO
@export var lerpTime:float
func _ready() -> void:
	Interaction()
	openPos += position
	closedPos = position
func _physics_process(delta: float) -> void:
	match state:
		Utilities.ITEM_STATE.ACTIVE:
			OpenDoor()
		Utilities.ITEM_STATE.NOT_ACTIVE:
			CloseDoor()
func OpenDoor():
	if position != openPos:
		position = lerp(position, openPos, lerpTime * get_physics_process_delta_time())
	else: return
func CloseDoor():
	if position != closedPos:
		position = lerp(position, closedPos, lerpTime * get_physics_process_delta_time())
	else: return
func Interaction():
	if state != newState:
		state = newState
