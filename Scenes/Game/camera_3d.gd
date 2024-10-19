extends Camera3D
@export var mouseSpeed := 0.5
@export var ctrlSpeed := 0.5
@export var pitch := Vector2.ZERO
@export var yaw := Vector2.ZERO
@onready var camInputs := Vector2.ZERO
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y*mouseSpeed*get_physics_process_delta_time()
		rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
		rotation.y -= event.relative.x*mouseSpeed*get_physics_process_delta_time()
		rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
func _physics_process(delta: float) -> void:
	pass
func CamInputs():
	camInputs = Input.get_vector("camLeft","camRight","camUp","camDown").normalized()
