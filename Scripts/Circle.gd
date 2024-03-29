@tool
extends Node2D
@export_range(0,1) var charge:float
func _draw():
	draw_arc(Vector2.ZERO, 160, -0.5236,0.5236,60, Color(1,1,1,0.5),8,false)
	var bloom = 6
	$"../Arrow".value = charge*5
	draw_arc(Vector2.ZERO, 160, -charge * 0.5236, charge* 0.5236,60, Color(bloom,bloom,bloom,1),8,false)
	
	
