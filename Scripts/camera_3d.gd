extends Camera3D
@export_group("CamGameplaySettings")
@export var mouseSpeed := 0.5
@export var ctrlSpeed := 0.5
@export var pitch := Vector2.ZERO
@export var yaw := Vector2.ZERO
@onready var camInputs := Vector2.ZERO
@export_group("RayCast")
@onready var ray := $Sight
var hitTarget : Node
var currentTarget : Node
var moveDirection : Vector3
var targetDirection : Vector2=Vector2.ZERO
var eventVector : Vector2=Vector2.ZERO
func _ready() -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _input(event: InputEvent) -> void:
	match Utilities.gameMode:
		Utilities.GAMEMODE.PLAYER:
			if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			if event is InputEventMouseMotion:
				rotation.x -= event.relative.y*mouseSpeed*get_physics_process_delta_time()
				rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
				rotation.y -= event.relative.x*mouseSpeed*get_physics_process_delta_time()
				rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
		Utilities.GAMEMODE.PUZZLE:
			if Input.mouse_mode != Input.MOUSE_MODE_CONFINED:
				Input.mouse_mode = Input.MOUSE_MODE_CONFINED
func _physics_process(delta: float) -> void:
		match Utilities.gameMode:
			Utilities.GAMEMODE.PLAYER:
				if current != true:
					current = true
				CamInputs()
			Utilities.GAMEMODE.PUZZLE:
				if current != false:
					current = false
				CamInputs()
	#if Input.is_action_pressed("LMB"):
		#if ray.is_colliding():
			#hitTarget = ray.get_collider()
		#if currentTarget != null and currentTarget == ray.get_collider():
			#MoveRayTarget(currentTarget)
		#if currentTarget != ray.get_collider():
			#ClearRayTarget(currentTarget)
	#if Input.is_action_just_pressed("LMB"):
		#if  hitTarget != null and hitTarget.is_in_group("pieces") and currentTarget == null:
			#currentTarget = hitTarget
	#if Input.is_action_just_released("LMB"):
		#currentTarget = null
func MoveRayTarget(node:Node):
	if node.movetype != Pieces.MOVETYPE.DOMOVE:
		node.movetype = Pieces.MOVETYPE.DOMOVE
	node.direction = Vector2(ray.get_collision_point().x,ray.get_collision_point().y)
func ClearRayTarget(node:Node):
	if currentTarget != null:
		if node.movetype != Pieces.MOVETYPE.DONTMOVE:
			node.movetype = Pieces.MOVETYPE.DONTMOVE
		currentTarget = null
func CamInputs():
	camInputs = Input.get_vector("camLeft","camRight","camUp","camDown").normalized()
	rotation.x -= camInputs.y*ctrlSpeed*get_physics_process_delta_time()
	rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
	rotation.y -= camInputs.x*ctrlSpeed*get_physics_process_delta_time()
	rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
