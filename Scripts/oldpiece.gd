#class_name Pieces
extends CharacterBody3D
enum PIECETYPE{NOTSOLID,SOLID}
@export var piecetype :PIECETYPE=PIECETYPE.NOTSOLID
enum MOVETYPE{DOMOVE,DONTMOVE}
@export var movetype :MOVETYPE=MOVETYPE.DONTMOVE
@export_group("Settings Sprite")
@export var cam : Node3D
@export var speed : float = 100.0
@export var adStream : AudioStreamPlayer
@onready var input_dirs := Vector3.ZERO
@onready var moveDirection := Vector3.ZERO
var selected : bool = false
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
				MOVETYPE.DONTMOVE:
					pass
				MOVETYPE.DOMOVE:
					if Utilities.gameMode == Utilities.GAMEMODE.PUZZLE and selected == true:
						Move_Piece(delta)
						velocity.x = input_dirs.x*speed*delta
						velocity.y = input_dirs.z*speed*delta
						velocity.z = 0
						velocity = velocity.rotated(Vector3.UP, cam.rotation.y)
						if input_dirs.length() != 0.0 and !adStream.playing:
							if !is_on_wall() || !is_on_floor()||!is_on_ceiling():
								adStream.play()
						if input_dirs.length() <= 0.0 and adStream.playing:
							if !is_on_wall() || !is_on_floor()||!is_on_ceiling():
								adStream.stop()
					move_and_slide()
func Move_Piece(DELTA:float):
	input_dirs.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dirs.z = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	input_dirs = input_dirs.normalized()
func Activate():
	if movetype != MOVETYPE.DOMOVE:
		selected = !selected
		movetype = MOVETYPE.DOMOVE
func Deactivate():
	if movetype != MOVETYPE.DONTMOVE:
		selected = !selected
		movetype = MOVETYPE.DONTMOVE
