extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in Global.items.size():
		$HUD/Control/Items.get_child(i).get_child(0).frame = Global.items[i].sprite_index
func _process(_delta):
	$HUD/Label.text = "  Bullets: " + str($"../Spawner".get_child_count())+"\n  FPS: "+str(Engine.get_frames_per_second())+"\n  Ammo: " + str(Global.ammo)+"\n  Room: " + str(Global.clearedrooms.size()+1)
	
	$Death.visible =Global.player.health <= 0


func _on_button_pressed():
	get_tree().reload_current_scene()
