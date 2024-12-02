extends CharacterBody3D
class_name PlayerBehaviour
@export var speed := 100.0
@export var jumpForce := 100.0
@onready var gravity := Vector3.ZERO
@onready var gravity_Direction = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
@onready var jumpVector := Vector3.ZERO
@onready var input_dirs := Vector3.ZERO
@onready var moveDirection := Vector3.ZERO
var onFocus :bool=false
var currentPuzzle : Node
@onready var cam :=$Camera3D
#@onready var stepSound = $AudioStreamPlayer3D
@onready var floorObj :Node
static var location :Vector3
#@onready var Concrete = "res://Sounds/SoundEffects/Passos 1.wav"
#@onready var Wood = "res://Sounds/SoundEffects/Passos 2.wav"

func _physics_process(delta: float) -> void:
	GameModeChecker()
	match Utilities.gameMode:
		Utilities.GAMEMODE.PLAYER:
			Jump(delta)
			Gravity(delta)
			MovePlayer(delta)
			#if moveDirection.length() > 0.2 || moveDirection.length() < -0.2:
				#if is_on_floor(): && !stepSound.playing:
					#FindFloor()
					#stepSound.play()
			#elif moveDirection.length() < 0.2 && moveDirection.length() > -0.2 && stepSound.playing:
				#stepSound.stop()
			velocity = moveDirection + gravity + jumpVector
			move_and_slide()
		Utilities.GAMEMODE.PUZZLE:
			pass
func Gravity(DELTA:float):
	if !is_on_floor():
		gravity += gravity_Direction * DELTA
	else:
		if gravity != -get_floor_normal():
			gravity = -get_floor_normal() * DELTA
func MovePlayer(DELTA:float):
	input_dirs.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dirs.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_dirs = input_dirs.rotated(Vector3.UP, cam.rotation.y).normalized()
	moveDirection = input_dirs.normalized() * speed * DELTA
func Jump(DELTA:float):
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jumpVector += transform.basis.y * jumpForce * DELTA
		await get_tree().create_timer(0.25).timeout
		if Input.is_action_pressed("ui_accept") and !is_on_floor():
			jumpVector -= transform.basis.y * jumpForce * DELTA
	if Input.is_action_just_released("ui_accept") and !is_on_floor():
		jumpVector -= transform.basis.y * jumpForce * DELTA
	if is_on_floor() && jumpVector != -get_floor_normal():
		jumpVector = -get_floor_normal() * DELTA
func _on_area_detection_body_entered(body: Node3D) -> void:
	Focus()
	if currentPuzzle == null:
		currentPuzzle = body
func _on_area_detection_body_exited(body: Node3D) -> void:
	Unfocus()
	currentPuzzle = null
func GameModeChecker():
	if Input.is_action_just_pressed("Switch")  && onFocus == true:
		if Utilities.gameMode != Utilities.GAMEMODE.PUZZLE:
			Utilities.gameMode = Utilities.GAMEMODE.PUZZLE
		else:
			Utilities.gameMode = Utilities.GAMEMODE.PLAYER
	else:
		return
func  Focus():
	$Layer_HUD/Control/Label.visible = !$Layer_HUD/Control/Label.visible
	onFocus = true
func Unfocus():
	$Layer_HUD/Control/Label.visible = !$Layer_HUD/Control/Label.visible
	onFocus = false
