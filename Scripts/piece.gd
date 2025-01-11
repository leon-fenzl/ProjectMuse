class_name Pieces
extends CharacterBody3D
enum PIECETYPE{NOTSOLID,SOLID}
@export var piecetype :PIECETYPE=PIECETYPE.NOTSOLID
enum MOVETYPE{DOMOVE,DONTMOVE}
@export var movetype :MOVETYPE=MOVETYPE.DONTMOVE
@export var nodeRef : Node
@export var speed : float = 100.0
@export var adStream : AudioStreamPlayer
@onready var input_dirs := Vector3.ZERO
@onready var moveDirection := Vector3.ZERO
var selected : bool = false
@onready var colShape := $Piece_Shape
var puzzle_Sfx = ["res://Sounds/SoundEffects/Arrastar Peça 1.wav", "res://Sounds/SoundEffects/Arrastar Peça 2.wav", "res://Sounds/SoundEffects/Arrastar Peça 3.wav", "res://Sounds/SoundEffects/Arrastar Peça 4.wav"]
var chosen_Int: int = 0
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	match piecetype:
		PIECETYPE.NOTSOLID:
			colShape.disabled = true
		PIECETYPE.SOLID:
			return
func _physics_process(delta: float) -> void:
	match piecetype:
		PIECETYPE.NOTSOLID:
			return
		PIECETYPE.SOLID:
			match movetype:
				MOVETYPE.DONTMOVE:
					pass
				MOVETYPE.DOMOVE:
					if Utilities.gameMode == Utilities.GAMEMODE.PUZZLE and selected == true:
						Inputs()
					Move_Piece(delta)
					AudioController()
					move_and_slide()
func Inputs():
	input_dirs.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dirs.z = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	input_dirs = input_dirs.normalized()
func Move_Piece(DELTA:float):
	velocity.x = input_dirs.x*speed*DELTA
	velocity.y = input_dirs.z*speed*DELTA
	velocity.z = 0
	velocity = velocity.rotated(Vector3.UP, nodeRef.rotation.y)
func Activate():
	if movetype != MOVETYPE.DOMOVE:
		selected = true
		movetype = MOVETYPE.DOMOVE
func Deactivate():
	if movetype != MOVETYPE.DONTMOVE:
		selected = false
		movetype = MOVETYPE.DONTMOVE
func AudioController():
	if input_dirs.length() != 0.0 and !adStream.playing:
		if !is_on_wall() || !is_on_floor()||!is_on_ceiling():
			var x = chosen_Int
			while chosen_Int == x:
				rng.randomize()
				chosen_Int = rng.randi_range(0, 3)
				adStream.stream = load(puzzle_Sfx[chosen_Int])
				adStream.play()
	if input_dirs.length() <= 0.0 and adStream.playing:
		if !is_on_wall() || !is_on_floor()||!is_on_ceiling():
			adStream.stop()
