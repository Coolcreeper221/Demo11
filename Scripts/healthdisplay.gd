extends TextureProgressBar

func _process(_delta):
	value = (Global.player.health+1)/float(Global.player.maxhealth) * max_value
	
