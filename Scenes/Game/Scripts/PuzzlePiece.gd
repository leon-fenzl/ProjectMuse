@tool
extends CharacterBody3D
#@export var texture : Texture2D:
	#get:
		#return texture
	#set(value):
		#if value != texture:
			#texture = value
			#UpdateSprite(texture)
#@export var split : Vector2:
	#get:
		#return split
	#set(value):
		#if value != split:
			#split = value
			#UpdateFrames(split)
#@export var cell : int:
	#get:
		#return cell
	#set(value):
		#if value != cell:
			#cell = value
			#UpdateCell(cell)
#@onready var sprite = $Sprite3D
#@onready var mousePos = null
#func UpdateSprite(value):
	#sprite.texture = value
#func UpdateCell(value):
	#sprite.frame = value
#func UpdateFrames(value):
	#sprite.hframes = value.x
	#sprite.vframes = value.y
func FollowMouse(mousePos):
	position.x += mousePos.x
	position.y += mousePos.y
