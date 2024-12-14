class_name GeneralConfig
extends Node

static var selfRef

func _init() -> void:
	selfRef = self

func _ready() -> void:
	selfRef = self
	var screen_size = DisplayServer.screen_get_size()
	print(screen_size)
	get_window().set_size(screen_size)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size / 2)
