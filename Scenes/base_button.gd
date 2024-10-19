extends Button
enum BEHAVIOUR{START,RESUME,RESTART,CHANGEMENU,QUIT}
@export var behaviour : BEHAVIOUR= BEHAVIOUR.START
@export var targetMenu : Node = null
func _on_button_down() -> void:
	match behaviour:
		BEHAVIOUR.START:
			get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")
		BEHAVIOUR.RESUME:
			get_tree().paused = !get_tree().paused
			targetMenu.visible = get_tree().paused
		BEHAVIOUR.RESTART:
			get_tree().paused = !get_tree().paused
			get_tree().reload_current_scene()
		BEHAVIOUR.CHANGEMENU:
			targetMenu.visible = get_tree().paused
		BEHAVIOUR.QUIT:
			get_tree().quit()
