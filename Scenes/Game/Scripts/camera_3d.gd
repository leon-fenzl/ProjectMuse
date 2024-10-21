extends Camera3D
#CamGameplaySettings
@export var mouseSpeed := 0.5
@export var ctrlSpeed := 0.5
@export var pitch := Vector2.ZERO
@export var yaw := Vector2.ZERO
@onready var camInputs := Vector2.ZERO
# RayCast
var mousePos = null
var targetNode : TextureRect = null
var rayLength := 1000.0
var rayStart = null
var rayEnd = null
var targetPiece = null
@onready var space = null
@onready var queryHit = null
@onready var holdPosition := Vector3.ZERO

@export var arrastar : AudioStream

var hitResults 
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and !Input.is_action_pressed("LMB"):
		rotation.x -= event.relative.y*mouseSpeed*get_physics_process_delta_time()
		rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
		rotation.y -= event.relative.x*mouseSpeed*get_physics_process_delta_time()
		rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
func _physics_process(delta: float) -> void:
	CamInputs()
	#CapturePiece(delta)
	DrawRay(delta)
func CamInputs():
	camInputs = Input.get_vector("camLeft","camRight","camUp","camDown").normalized()
	rotation.x -= camInputs.y*ctrlSpeed*get_physics_process_delta_time()
	rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
	rotation.y -= camInputs.x*ctrlSpeed*get_physics_process_delta_time()
	rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
#func CapturePiece(DELTA:float):
	#mousePos = get_viewport().get_mouse_position()
	#ray.global_position = get_viewport().get_camera_3d().project_position(mousePos,0.25)
	#if Input.is_action_pressed("LMB"):
		#Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		#if ray.is_colliding() and ray.get_collider().is_in_group("pieces"):
			#if targetPiece == null:
				#targetPiece = ray.get_collider()
		#if targetPiece != null:
			#targetPiece.global_position.x = ray.global_position.x
			#targetPiece.global_position.y = ray.global_position.y
			#print(targetPiece.position)
	#if Input.is_action_just_released("LMB"):
		#targetPiece = null
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func DrawRay(DELTA:float):
	if Input.is_action_pressed("LMB"):
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		mousePos = get_viewport().get_mouse_position()
		rayStart = get_viewport().get_camera_3d().project_ray_origin(mousePos)
		rayEnd = get_viewport().get_camera_3d().project_position(mousePos,1000.0)
		space = get_world_3d().direct_space_state
		queryHit = PhysicsRayQueryParameters3D.new()
		queryHit.from = rayStart
		queryHit.to = rayEnd
		var hitResults = space.intersect_ray(queryHit)
		if !hitResults.is_empty():
			if hitResults.collider.is_in_group("pieces") and targetPiece == null:
				targetPiece = hitResults.collider
				#Arrastar com som
				#get_node("AudioStreamPlayer").play()
			if targetPiece != null:
				holdPosition = get_viewport().get_camera_3d().project_position(mousePos,1)
				targetPiece.global_position.x = holdPosition.x
				targetPiece.global_position.y = holdPosition.y
	if Input.is_action_just_released("LMB"):
		targetPiece = null
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
