@tool
extends TextureProgressBar
@export_range(0,1) var charge:float

func _draw():
	
	var bloom = 4
	var col =  Color(bloom,bloom*clamp(.05*(Global.ammo),0,1),bloom*clamp(.05*(Global.ammo),0,1),1)
	#$"../Arrow".value = charge*5
	$"../Arrow".modulate = col
	value = charge *14 
	modulate = col

	
	
