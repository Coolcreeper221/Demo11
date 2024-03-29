extends Node

@export var items:Array[item]
@export var player:CharacterBody2D
@export var shake:float

func _process(delta):
	if shake:
		var cam = player.find_child("Camera2D")
		randomize()
		var dir = Vector2(randf_range(-1,1),randf_range(-1,1))
		cam.offset = dir*shake*100
		shake=move_toward(shake,0,delta)
