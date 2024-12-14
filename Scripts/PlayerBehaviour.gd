extends CharacterBody3D
class_name PlayerBehaviour
@export var speed := 100.0
@export var jumpForce := 100.0
@onready var gravity := Vector3.ZERO
@onready var gravity_Direction = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
@onready var jumpVector := Vector3.ZERO
@onready var input_dirs := Vector3.ZERO
@onready var moveDirection := Vector3.ZERO
@export var playeraudio : PlayerAudioController 
var onFocus : bool = false
var currentPuzzle : Node
@onready var cam :=$Camera3D
@onready var floorObj :Node
static var location :Vector3
@onready var floor_ray := $Feet
@onready var floor_group
@onready var audio_stream_player_steps: AudioStreamPlayer = $AudioStreamPlayerSteps
const concrete = preload("res://Sounds/SoundEffects/Passos 1.wav")
const wood = preload("res://Sounds/SoundEffects/Passos 2.wav")
@onready var floor_name
static var playerRef : Node
func _init() -> void:
	playerRef = self
func _physics_process(delta: float) -> void:
	GameModeChecker()
	match Utilities.gameMode:
		Utilities.GAMEMODE.PLAYER:
			Jump(delta)
			Gravity(delta)
			MovePlayer(delta)
			#if moveDirection.length() > 0.2 || moveDirection.length() < -0.2:
				#FindFloor()
			#else:
				#audio_stream_player_steps.stop()
				#if is_on_floor(): && !stepSound.playing:
					#FindFloor()
					#stepSound.play()
			#elif moveDirection.length() < 0.2 && moveDirection.length() > -0.2 && stepSound.playing:
				#stepSound.stop()
			velocity = moveDirection + gravity + jumpVector
			move_and_slide()
		Utilities.GAMEMODE.PUZZLE:
			pass
			
		#match audiotype:
			#AUDIOTYPE.GROUND:
				#IF current audio != newaUDIO:
					#CURRENTAUDIO = NEWAUDIO
				#CURRENTAUDIO PLAY
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
	if input_dirs != Vector3.ZERO:
		FindFloor()
		if  !audio_stream_player_steps.playing:
			audio_stream_player_steps.play()
	elif input_dirs == Vector3.ZERO && audio_stream_player_steps.playing:
		audio_stream_player_steps.stop()
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
func GameModeChecker():
	if Input.is_action_just_pressed("Switch")  && onFocus == true:
		if Utilities.gameMode != Utilities.GAMEMODE.PUZZLE:
			Utilities.gameMode = Utilities.GAMEMODE.PUZZLE
		else:
			Utilities.gameMode = Utilities.GAMEMODE.PLAYER
	else:
		return
func FindFloor():
	if floor_ray.is_colliding():
		floor_group = floor_ray.get_collider()
		floor_name = floor_group.name
		match floor_name:
			"Ground":
				if audio_stream_player_steps.stream.resource_path != wood.resource_path:
					audio_stream_player_steps.stop()
					audio_stream_player_steps.stream = wood
			"Ground2":
				if audio_stream_player_steps.stream.resource_path != concrete.resource_path:
					audio_stream_player_steps.stop()
					audio_stream_player_steps.stream = concrete
			"_":
				audio_stream_player_steps.stop()
				audio_stream_player_steps.stream = wood

	
