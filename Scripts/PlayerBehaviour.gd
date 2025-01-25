extends CharacterBody3D
class_name PlayerBehaviour
@export var maxSpeed := 500.0
@export var minSpeed := 200.0
var speed := minSpeed
@export var jumpForce := 100.0
@onready var gravity := Vector3.ZERO
@onready var gravity_Direction = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
@onready var jumpVector := Vector3.ZERO
@onready var input_dirs := Vector3.ZERO
@onready var moveDirection := Vector3.ZERO
@export var playeraudio : PlayerAudioController 
var onFocus : bool = false
var currentPuzzle : Node
@onready var playerCam := $Camera3D
@onready var paintCam := $Camera3D
@onready var floorObj :Node
static var location :Vector3
@onready var floor_ray := $Feet
@onready var floor_group
@onready var audio_stream_player_steps: AudioStreamPlayer = $AudioStreamPlayerSteps
const concrete = preload("res://Sounds/SoundEffects/Passos 1.wav")
const concrete_Run = preload("res://Sounds/SoundEffects/Corrida 1.wav")
const wood = preload("res://Sounds/SoundEffects/Passos 2.wav")
const wood_Run = preload("res://Sounds/SoundEffects/Corrida 2.wav")
const jump_Sound = preload("res://Sounds/SoundEffects/Pulo 1.wav")
@onready var floor_name
static var playerRef : Node
@export var current := false
@onready var bg_music = get_node("%AudioStreamPlayer3D2")

func _init() -> void:
	playerRef = self
func _ready() -> void:
	speed = minSpeed
func _physics_process(delta: float) -> void:
	GameModeChecker()
	match Utilities.gameMode:
		Utilities.GAMEMODE.PLAYER:
			Jump(delta)
			Gravity(delta)
			Run()
			MovePlayer(delta)
			velocity = moveDirection + gravity + jumpVector
			move_and_slide()
			if input_dirs != Vector3.ZERO && is_on_floor():
				FindFloor()
				if  !audio_stream_player_steps.playing:
					audio_stream_player_steps.play()
			elif input_dirs == Vector3.ZERO && audio_stream_player_steps.playing && is_on_floor():
				audio_stream_player_steps.stop()
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
	input_dirs = input_dirs.rotated(Vector3.UP, playerCam.rotation.y).normalized()
	moveDirection = input_dirs.normalized() * speed * DELTA
func Run():
	if Input.is_action_just_pressed("run"):
		speed = maxSpeed
	if Input.is_action_just_released("run"):
		speed = minSpeed
func Jump(DELTA:float):
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jumpVector += transform.basis.y * jumpForce * DELTA
		audio_stream_player_steps.stop()
		audio_stream_player_steps.stream = jump_Sound
		audio_stream_player_steps.play()
		await get_tree().create_timer(0.25).timeout
		if Input.is_action_pressed("ui_accept") and !is_on_floor():
			jumpVector -= transform.basis.y * jumpForce * DELTA
	if Input.is_action_just_released("ui_accept") and !is_on_floor():
		jumpVector -= transform.basis.y * jumpForce * DELTA
	if is_on_floor() && jumpVector != -get_floor_normal():
		jumpVector = -get_floor_normal() * DELTA
func FindFloor():
	if floor_ray.is_colliding():
		floor_group = floor_ray.get_collider()
		floor_name = floor_group.name
		match floor_name:
			"GM_Floor":
				if audio_stream_player_steps.stream.resource_path != wood.resource_path && speed == minSpeed:
					audio_stream_player_steps.stop()
					audio_stream_player_steps.stream = wood
				if audio_stream_player_steps.stream.resource_path != wood_Run.resource_path && speed == maxSpeed:
					audio_stream_player_steps.stop()
					audio_stream_player_steps.stream = wood_Run
			"Ground2":
				if audio_stream_player_steps.stream.resource_path != concrete.resource_path && speed == minSpeed:
					audio_stream_player_steps.stop()
					audio_stream_player_steps.stream = concrete
				elif audio_stream_player_steps.stream.resource_path != concrete_Run.resource_path && speed == maxSpeed:
					audio_stream_player_steps.stop()
					audio_stream_player_steps.stream = concrete_Run
			"_":
				audio_stream_player_steps.stop()
				audio_stream_player_steps.stream = wood
func GameModeChecker():
	if Input.is_action_just_pressed("Switch")  && onFocus == true:
		if Utilities.gameMode != Utilities.GAMEMODE.PUZZLE:
			Utilities.gameMode = Utilities.GAMEMODE.PUZZLE
			playerCam.current = false
			paintCam.current = true
			bg_music.restrictedArea = true
			%AudioStreamPlayer3D2.stop()
			audio_stream_player_steps.stop()
		else:
			Utilities.gameMode = Utilities.GAMEMODE.PLAYER
			playerCam.current = true
			paintCam.current = false
			bg_music.restrictedArea = false
			%AudioStreamPlayer3D2.stop()
			audio_stream_player_steps.stop()
	else:
		return
	
