extends Resource
class_name Utilities
enum ITEM_STATE{NOT_ACTIVE,ACTIVE}
enum GAMEMODE{PLAYER,PUZZLE}
static var gameMode:GAMEMODE=GAMEMODE.PLAYER
enum CHANGEDIRECTION{HUB,P_ONE}
static var museum:="res://Scenes/Game/Game.tscn"
static var paintingOne:="res://Scenes/Game/Game2.tscn"
static var playerRef:Node=null
static func GetPlayerNode(node:Node=null):
	playerRef = node
static func ReturnPlayerNode():
	return playerRef
