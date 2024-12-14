class_name Pieces
extends CharacterBody3D
enum PIECETYPE{NOTSOLID,SOLID}
@export var piecetype :PIECETYPE=PIECETYPE.NOTSOLID
enum MOVETYPE{DOMOVE,DONTMOVE}
@export var movetype :MOVETYPE=MOVETYPE.DONTMOVE
@export_group("Settings Sprite")
@export var cam : Camera3D
@export var speed : float = 100.0
@export var adStream : AudioStreamPlayer
@onready var input_dirs := Vector3.ZERO
@onready var moveDirection := Vector3.ZERO
func _ready() -> void:
	match piecetype:
		PIECETYPE.NOTSOLID:
			$Col_Piece.disabled = true
		PIECETYPE.SOLID:
			return
func _physics_process(delta: float) -> void:
	match piecetype:
		PIECETYPE.NOTSOLID:
			return
		PIECETYPE.SOLID:
			match movetype:
				MOVETYPE.DOMOVE:
					if Utilities. gameMode == Utilities.GAMEMODE.PUZZLE:
						Move_Piece(delta)
						velocity = moveDirection
				MOVETYPE.DONTMOVE:
					pass
	move_and_slide()
func Move_Piece(DELTA:float):
	input_dirs.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dirs.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	input_dirs = input_dirs.rotated(Vector3.UP, cam.rotation.y).normalized()
	moveDirection = input_dirs.normalized() * speed * DELTA
	if input_dirs != Vector3.ZERO && !adStream.playing:
		adStream.play()
func Activate():
	if movetype != MOVETYPE.DOMOVE:
		movetype = MOVETYPE.DOMOVE
func Deactivate():
	if movetype != MOVETYPE.DONTMOVE:
		movetype = MOVETYPE.DONTMOVE
