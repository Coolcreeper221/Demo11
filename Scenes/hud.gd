extends Control


# Called when the node enters the scene tree for the first time.
#func _ready():
	#for i in Global.items.size():
	#	$CanvasLayer/Control/Items.get_child(i).get_child(0).frame = Global.items[i].sprite_index
func _process(_delta):
	$CanvasLayer/Label.text = "  Bullets: " + str($"../Spawner".get_child_count())+"\n  FPS: "+str(Engine.get_frames_per_second())
