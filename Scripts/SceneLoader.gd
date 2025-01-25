class_name SceneLoader
extends Node
#Essa variável precisa ser Redeclarada em todo lugar que chamar LOADSCENE
@export var targetStringLocation : String
#Variável que amarzena o string completo de on
var full_path : String
var isLoading : bool = false 
var sceneInstance : Node
@export var loadingScreen : Node
static var selfRef
func _init() -> void:
	selfRef = self
func _ready() -> void:
	Load_Scene(targetStringLocation)
	#print(get_tree().root.get_child(0))
	#print(GeneralConfig.selfRef)
##Call this to load a new scene
##How to call SceneLoader.selfRef.Load_Scene("res://Scenes/Game/Game.tscn")
func Load_Scene(applyTargetStringLocation):
	if isLoading:
		return
	isLoading = true
	Loading_Screen_Visibility()
	Clear_SceneInstance()
	full_path = applyTargetStringLocation
	ResourceLoader.load_threaded_request(full_path)
	LoadingNewScene()
var loadProgress = []
func LoadingNewScene():
	##Loading loop
	if ResourceLoader.load_threaded_get_status(full_path,loadProgress) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().create_timer(.1).timeout
		LoadingNewScene()
		return
	Add_Set_CurrentScene(full_path)
	await get_tree().create_timer(1).timeout
	Loading_Screen_Visibility()
	isLoading = false
func Add_Set_CurrentScene(path):
	sceneInstance = ResourceLoader.load(full_path).instantiate()
	get_child(0).add_child.call_deferred(sceneInstance)
func Clear_SceneInstance():
	if sceneInstance != null:
		sceneInstance.queue_free()
		sceneInstance = null
func Loading_Screen_Visibility():
	if loadingScreen.visible != !loadingScreen.visible:
		loadingScreen.visible = !loadingScreen.visible
func SaveDict():
	var save_dict
	return save_dict
