@tool
extends Node2D
class_name Position2D


func _draw():
	if Engine.is_editor_hint():
		draw_texture(load("res://assets/tools/marker.png"), Vector2(-2,-8))
