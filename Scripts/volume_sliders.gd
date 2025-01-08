extends HSlider


@export
var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	self.release_focus()
