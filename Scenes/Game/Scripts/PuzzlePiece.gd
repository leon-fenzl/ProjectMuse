extends TextureRect
@onready var mouseOver := false
@onready var mousePos = null
func _physics_process(delta: float) -> void:
	if mouseOver == true:
		position.x = (get_global_mouse_position().x-64.0)
		position.y = (get_global_mouse_position().y-64.0)
func _on_mouse_entered() -> void:
	mouseOver = true
func _on_mouse_exited() -> void:
	mouseOver = false
