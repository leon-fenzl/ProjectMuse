class_name PuzzleCamera
extends Camera3D
@export_group("RayCast")
var hitTarget : Node
var currentTarget : Node
var moveDirection : Vector3
var targetDirection : Vector2=Vector2.ZERO
@export var rayLength := 1000.0
var mousePos 
var query
var intersection
static var  puzzleCamRef : Node
func _init() -> void:
	puzzleCamRef = self
func _physics_process(delta: float) -> void:
		match Utilities.gameMode:
			Utilities.GAMEMODE.PLAYER:
				pass
			Utilities.GAMEMODE.PUZZLE:
				MouseRaySelection()
				SelectNodes()
func MouseRaySelection():
	mousePos = get_viewport().get_mouse_position()
	query = PhysicsRayQueryParameters3D.new()
	query.from = project_ray_origin(mousePos)
	query.to = query.from + project_ray_normal(mousePos)*rayLength
	intersection = get_world_3d().direct_space_state.intersect_ray(query)
func SelectNodes():
	if Input.is_action_just_pressed("LMB"):
		if !intersection.is_empty():
			if hitTarget == null && intersection.collider.is_in_group("pieces"):
				hitTarget = intersection.collider
			if intersection.collider.is_in_group("pieces") && hitTarget != null && hitTarget !=  intersection.collider:
				hitTarget.Deactivate()
				hitTarget =  intersection.collider
		else:
			if hitTarget != null:
				hitTarget = null 
		if hitTarget != null:
			hitTarget.Activate()
