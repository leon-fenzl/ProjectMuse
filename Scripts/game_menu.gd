extends CanvasLayer
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _input(event):
	if Input.is_action_just_pressed("Escape"):
		get_tree().paused = !get_tree().paused 
		self.visible = get_tree().paused
	if get_tree().paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#tratlalalalalalala
