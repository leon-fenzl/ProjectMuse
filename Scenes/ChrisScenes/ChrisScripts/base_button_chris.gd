extends Button
enum BEHAVIOUR{START,RESUME,RESTART,CHANGEMENU,QUIT}
@export var behaviour : BEHAVIOUR= BEHAVIOUR.START
@export var targetMenu : Node = null
@export var click : AudioStream


func _ready() -> void:
		if behaviour == BEHAVIOUR.RESUME && targetMenu == null:
			targetMenu = $"../.."

func _on_button_down() -> void:
	get_node("AudioStreamPlayer").stream = load("res://Sounds/SoundEffects/Click.wav")
	get_node("AudioStreamPlayer").play()
	match behaviour:
		BEHAVIOUR.START:
			await  $AudioStreamPlayer.finished
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
			await $"../BaseButton2/AudioStreamPlayer".finished
			get_tree().quit()
