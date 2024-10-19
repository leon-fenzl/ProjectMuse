extends Control
var mousePos = null
var targetNode : TextureRect = null
@export var puzzlePieces :Array[TextureRect]=[] 
func _physics_process(delta: float) -> void:
	mousePos = get_global_mouse_position()
	$ShapeCast2D.position = mousePos
	RealtimeOverlap()
	if Input.is_action_pressed("LMB"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if targetNode != null:
			targetNode.mousePos = mousePos
	if Input.is_action_just_released("LMB"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func RealtimeOverlap():
	if $ShapeCast2D.is_colliding():
		if $ShapeCast2D.get_collider(0).is_in_group("piece"):
			targetNode = $ShapeCast2D.get_collider()
			print(targetNode)
