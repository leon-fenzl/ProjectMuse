extends StaticBody3D
enum DIRECTIONS{D1,D2,D3}
@export var lerpSpeed := 100.0
@export var directions :DIRECTIONS=DIRECTIONS.D1
var newDirection : Vector3
func _ready():
	match directions:
		DIRECTIONS.D1:
			newDirection = Vector3.UP
func OpenDoor(DELTA:float):
	position = lerp(position,newDirection,lerpSpeed*DELTA)
