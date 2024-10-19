extends CharacterBody3D
@export var speed := 100.0
@export var jumpForce := 100.0
@onready var gravity := Vector3.ZERO
@onready var jumpVector := Vector3.ZERO
@onready var input_dirs := Vector3.ZERO
@onready var moveDirection := Vector3.ZERO
@onready var cam = $Camera3D
@onready var stepSound = $AudioStreamPlayer3D
func _physics_process(delta: float) -> void:
	# Gravidade
	if not is_on_floor():
		gravity += get_gravity() * delta
	else:
		gravity = -get_floor_normal() * delta
	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jumpVector += transform.basis.y * jumpForce * delta
		await get_tree().create_timer(0.25).timeout
		if Input.is_action_pressed("ui_accept") and !is_on_floor():
			jumpVector -= gravity * jumpForce * delta
	if Input.is_action_pressed("ui_accept") and !is_on_floor():
		jumpVector = Vector3.ZERO
	# Movimento
	input_dirs.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dirs.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_dirs = input_dirs.rotated(Vector3.UP, cam.rotation.y).normalized()
	moveDirection = input_dirs.normalized()*speed*delta
	if moveDirection.length() > 0.2 || moveDirection.length() < -0.2:
		if is_on_floor() && !stepSound.playing:
			stepSound.play()
	elif moveDirection.length() < 0.2 && moveDirection.length() > -0.2 && stepSound.playing:
		stepSound.stop()
	velocity = moveDirection + gravity + jumpVector
	move_and_slide()
