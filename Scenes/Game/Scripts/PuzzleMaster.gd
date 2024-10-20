extends Node
@export var locks:Array[Area3D]
@export var solution:Array[int]
var isChecking := false
var index :int=0 
var onPlace := false

@export var vitoria : AudioStream

func _physics_process(delta: float) -> void:
	CheckSolution()
func CheckSolution():
	for index in range(index,locks.size()-1):
		index += 1
		if index >= locks.size()-1:
			##Vitoria
			Completed()
			get_node("AudioStreamPlayer").play(vitoria)
			if has_node("MovableDoor"):
				get_node("MovableDoor").Open_Door()
		else:
			return
static func Completed():
	return true
static  func NotCompleted():
	return false
