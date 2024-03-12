extends Node2D


func _ready():
	pass
func spawn(host:Node2D,inp:Dictionary,manager:PackedScene):
	var newmanager = manager.instantiate()
	inp.merge({"pos":host.global_position,"rot":host.global_rotation})
	newmanager.input = inp
	add_child(newmanager,true)
	
