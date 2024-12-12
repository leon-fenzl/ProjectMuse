extends CharacterBody3D
class_name Pieces
enum PIECETYPE{NOTSOLID,SOLID}
@export var piecetype :PIECETYPE=PIECETYPE.NOTSOLID
enum MOVETYPE{DOMOVE,DONTMOVE}
@export var movetype :MOVETYPE=MOVETYPE.DONTMOVE
@export_group("Settings Sprite")
var sprite : Sprite3D = Sprite3D.new()
@export var cam : Camera3D
@export var speed : float = 100.0
@export var adStream : AudioStreamPlayer
@onready var input_dirs := Vector3.ZERO
@onready var moveDirection := Vector3.ZERO
#var direction := Vector2.ZERO
#var fps : float
#var underay : bool = false
@export var texture :Texture2D:
	get():
		return texture
	set(value):
		texture = value
		Update_Texture(value)
@export var split :Vector2:
	get():
		return split
	set(value):
		if value != split:
			split = value
			Update_HFrames(value.x)
			Update_VFrames(value.y)
@export var frame:int:
	get():
		return frame
	set(value):
		if value != frame:
			frame = value
			Update_Frames(value)
func _ready() -> void:
	Construct_Object_Ingame()
	match piecetype:
		PIECETYPE.NOTSOLID:
			$CollisionShape3D.disabled = true
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
						move_and_slide()
				MOVETYPE.DONTMOVE:
					pass
	move_and_slide()
func Update_Texture(value):
	sprite.texture = value
func Update_HFrames(value):
	sprite.hframes = value
func Update_VFrames(value):
	sprite.vframes = value
func Update_Frames(value):
	sprite.frame = value
func DrawCol(value):
	$".".add_child(value)
func Construct_Object_Ingame():
	$".".add_child(sprite)
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
