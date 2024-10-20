extends StaticBody3D
@export var pieces:Array[CharacterBody3D]
@export var solution:Array[int]
var isChecking := false
var index :int=0
func CheckSolution():
	while isChecking == true:
		if solution[index] == pieces[index].value:
			index += 1
		else:
			index = 0
