extends Node2D

@export var roomdirectories:PackedStringArray
@export var roomorder:PackedStringArray
var rooms:Array
var placepos:Vector2=Vector2.ZERO
var placeangle:float=45

func _ready():

	randomize()
	for i in roomdirectories:
		var rname
		if i.contains("res://"):
			rname = i.erase(0,19)
		else:
			rname = i.erase(0,12)
		var modules = dir_contents(i)
		
		if modules:
			rooms.append({"type":rname,"modules":modules})
	print(rooms)
	for i in roomorder:
		var modules
		for j in rooms:
			if j["type"] == i:
				modules = j["modules"]
		if !modules:
			break
		
		var randroom = load(modules.pick_random()).instantiate()
		var passes =false
		while passes ==false:
			if randroom.get_entrance_angle()==placeangle:
				randroom.position = placepos-randroom.get_entrance().position
				passes = true
			else :
				randroom = load(modules.pick_random()).instantiate()
				randomize()
				
		placepos = randroom.get_exit().global_position
		placeangle= randroom.get_exit_angle()
		add_child(randroom)
	$NavigationRegion2D.bake_navigation_polygon()
	$NavigationRegion2D2.bake_navigation_polygon()


func dir_contents(path):
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		@warning_ignore("unassigned_variable")
		var names:Array
		while file_name != "":
			names.append(path+"/"+file_name)
		
			file_name = dir.get_next()
		return names
