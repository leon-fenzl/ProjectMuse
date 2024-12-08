extends Node
#Posição de SPAWN relatico ao centro do mundo da cena HUB/MAIN/GAME (cena principal)
@export var spawnPosition := Vector3.ZERO
# Ter como noção a cena atual a ser carregada, através de INTs
@export var paintScenes : Array [PackedScene]
var ps_Intstance : Node = null
#ou você declara como uma PaintScene, mas ai precisa criar o script base para todas as PAINTSCENES, E elas precisam
#Ou ter como noão a cena a ser carregada, como enum
#Porém, como é um ENUM, mesmo assim a 
#posição da VAR dentro do enum ainda segue a lógica de um ARRAY (0,1,2,...N)
#enum PAINTSCENES{PAINT_ONE,PAINT_TWO} <<<<<
#var currentPaintScene : PAINTSCENES = PAINTSCENES.PAINT_ONE
# função teste
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("TEST_INPUT"):
		if ps_Intstance != null:
			ps_Intstance.queue_free()
			ps_Intstance = null
			print(ps_Intstance)
		else:
			ps_Intstance = paintScenes[0].instantiate()
#			Call Deferred força a função add-child a acontecer.
			get_parent().add_child.call_deferred(ps_Intstance)
			ps_Intstance.position = ps_Intstance.position + spawnPosition
#mob_instance = mobs_resources[mobResIndex].instantiate()
#mob_instance.player = player_instance
#get_parent().add_child.call_deferred(mob_instance)
#mob_instance.position = position + (Vector3.UP * 2)
