extends StaticBody3D

var markerPosition = Vector3(0,0,0)
@export var velocidade : float = 0.01
var time : float = 0
##@export var 
##@export var targetPosition : Vector3()

func _ready() -> void:
	pass # Replace with function body.	
	##get the final position
	markerPosition = get_node("Marker3D")

##Chamar essa funcao
func Open_Door():
	##Start opennig the door
	OpeningDoor()
	##tocar audio
	get_node("AudioStreamPlayer").play()
	
func OpeningDoor():
	if time <= 1:
		time += get_process_delta_time() * velocidade
		position = position.lerp(markerPosition.position,time)
		await get_tree().create_timer(0,0001).timeout
		OpeningDoor()
		return
 


##physiscs process
##Unique name
