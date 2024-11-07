extends CharacterBody3D
class_name Pieces
enum PIECETYPE{NOTSOLID,SOLID}
@export var piecetype :PIECETYPE=PIECETYPE.NOTSOLID
enum MOVETYPE{DONTMOVE,DOMOVE}
@export var movetype :MOVETYPE=MOVETYPE.DONTMOVE
@export_group("Settings Sprite")
var sprite : Sprite3D = Sprite3D.new()
var moveDirection := Vector3.ZERO
var direction := Vector2.ZERO
var fps : float
var underay : bool = false
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
	fps = Engine.get_frames_per_second()
	if Input.is_action_just_released("LMB"):
		if movetype != MOVETYPE.DONTMOVE:
			movetype = MOVETYPE.DONTMOVE
	match piecetype:
		PIECETYPE.NOTSOLID:
			return
		PIECETYPE.SOLID:
			match movetype:
				MOVETYPE.DONTMOVE:
					velocity = Vector3.ZERO
				MOVETYPE.DOMOVE:
					moveDirection = Vector3(direction.x,direction.y,position.z)
					velocity = (moveDirection - position)/delta
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
