extends OptionButton


@onready var option_button: OptionButton = $"."

#resoluções disponiveis
var resolutions = {
	"3840x2160": Vector2i(3840,2160),
	"2560x1440": Vector2i(2560,1440),
	"1920x1080": Vector2i(1920,1080),
	"1366x768": Vector2i(1366,768),
	"1280x720": Vector2i(1280,720),
	"1440x900": Vector2i(1440,900),
	"1600x900": Vector2i(1600,900),
	"1024x600": Vector2i(1024,600),
	"800x600": Vector2i(800,600)
}

func _ready():
	#adiciona reoluções ao botão dropdown
	for r in resolutions:
		option_button.add_item(r)
	
	#screve o tamanho encontrado de tela no dropdown padrão
	var window_size_str = str(get_window().size.x, "x", get_window().size.y)
	var resolution_index = resolutions.keys().find(window_size_str)
	option_button.selected = resolution_index
	


func _on_item_selected(index):
	#ao selecionar uma nova reolução, muda o tamanho do canvas
	var key = option_button.get_item_text(index)
	get_window().set_size(resolutions[key])
	
	#centraliza o canvas na tela
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size / 2)
