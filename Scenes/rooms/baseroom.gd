extends VisibleOnScreenNotifier2D
class_name room
@export var entrance:Position2D
@export var exit:Position2D
@export var aenter:float
@export var aexit:float
func _ready():
	connect("screen_entered",_show)
	connect("screen_exited",_hide)
	$Baseroom.hide()
	$Baseroom.add_to_group("navigation",true)
	$".".rect = Rect2i($Baseroom.get_used_rect().position *16, $Baseroom.get_used_rect().size *16)

	clear_excess()
func _show():
	$Baseroom.visible = true
func _hide():
	$Baseroom.visible = false
	
func clear_excess():
	get_exit()
	get_entrance()
	get_exit_angle()
	get_entrance_angle()
	for i in get_children():
		if i.name == "entrance" or i.name == "exit":
			i.queue_free()
		elif i.name == "melee":
			await get_tree().process_frame
			i.reparent(get_tree().get_root().get_child(1))
	

func get_exit():
	if !exit:
		for i in get_children():
			if i.name.contains("exit"):
				exit=i
	return exit
func get_entrance():
	if !entrance:
		for i in get_children():
			if i.name.contains("entrance"):
				entrance=i
	return entrance
func get_exit_angle():
	if !aexit:
		for i in get_children():
			if i.name.contains("exit"):
				aexit=round(i.rotation_degrees)
	return aexit
func get_entrance_angle():
	if !aenter:
		for i in get_children():
			if i.name.contains("entrance"):
				aenter=round(i.rotation_degrees)
			
	return aenter
