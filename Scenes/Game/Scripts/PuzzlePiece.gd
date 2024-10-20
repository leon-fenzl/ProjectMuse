extends CharacterBody3D
enum PIECETYPE{NOTSOLID,SOLID}
@export var piecetype :PIECETYPE = PIECETYPE.NOTSOLID
#@export var shape : Shape3D
@export var keyValue : int
@export var cuts : float
@onready var colShape := $CollisionShape3D
@export var img : Texture
@onready var sprite := $Sprite3D
func _ready() -> void:
	#SetShapeType()
	SetSprite()
func FollowMouse(newPosition):
	position.x = newPosition.x
	position.y = newPosition.y
#func SetShapeType():
	#match piecetype:
		#PIECETYPE.NOTSOLID:
			#return
		#PIECETYPE.SOLID:
			#colShape.shape = shape
func SetSprite():
	sprite.hframes = cuts
	sprite.vframes = cuts
	sprite.frame = keyValue
	sprite.texture = img
