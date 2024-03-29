extends TextureProgressBar

func _process(_delta):
	value = Global.player.health/float(Global.player.maxhealth) * max_value
	
