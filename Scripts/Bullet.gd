extends CharacterBody2D
@export var input:Dictionary
var speed:float
var maxbounces:int
var curve:Curve
var curveloop:bool
var homing:bool
var target:Node2D
@export var sprite:Texture
var curvetime:float = 0.0
var precurveangle:float = 0.0
var agent:NavigationAgent2D
var pre_pos:Vector2
var player:bool
func _draw():
	draw_texture(sprite, Vector2(-8,-8))

func _ready() -> void:
	global_position=  input["pos"]
	player = input["player"]
	speed = input["speed"]
	maxbounces=input["bounces"]
	curve = input["curve"]
	curveloop = input["curveloop"]
	homing =  input["homing"]
	target =  input["target"]
	#{"speed":bspeed,"bounces":maxbounces,"curve":curve,"curveloop":curveloop,"homing":homing,"target":target,"player":player})

	
	#initial
	velocity = Vector2(1,0).normalized().rotated(input["rot"])*speed

	if homing:
		agent= NavigationAgent2D.new()
		add_child(agent,true)
		var timer = Timer.new()
		timer.wait_time = .2
		
		agent.add_child(timer,true)
		timer.connect("timeout",_update_path)
		timer.start()
		if target:
			$Area2D.queue_free()
func _update_path() -> void:
	if is_instance_valid(target):
		agent.target_position = target.global_position
func _physics_process(_delta)-> void:
	if !is_instance_valid(target):
		target = null
	#Curve
	if curve:
		
		if curvetime == 0.0:
			precurveangle =  wrapf(rad_to_deg(input["rot"]),0,360)
		var turnval = (precurveangle+90*curve.sample(curvetime))-rad_to_deg(input["rot"])
		input["rot"] += deg_to_rad(turnval)
		turnval =  wrapf(turnval,0,360)
		velocity = velocity.rotated(deg_to_rad(turnval))
	
		curvetime+=_delta
		if curvetime > 1 and curveloop:
			curvetime = 0.0
			precurveangle = rad_to_deg(input["rot"])
	move_and_slide()
	#pathfinding
	if homing:
		if target:
			var dir = global_position.direction_to(agent.get_next_path_position())
			if dir.length()>0.5:
				velocity = velocity.move_toward(dir*speed,_delta*4*speed)
			
		else:
			@warning_ignore("unassigned_variable")
			var possible_targets:Array
			for i in $Area2D.get_overlapping_bodies():
				if !i.name.contains("Bullet") and !i.name.contains("Map"):
					if player and !i.name.contains("player"):
						possible_targets.append(i)
					
					elif !player:
						possible_targets.append(i)
			var minval = 180
			var chosen:Node2D
			for i in possible_targets:
				if (global_position-i.global_position).length()<minval:
					chosen = i
			target = chosen
	if pre_pos.distance_to(position) == 0:
		queue_free()
	else:
		pre_pos= position


	#bounce
	var  colcount = get_slide_collision_count()
	if colcount and !target:
		var col:KinematicCollision2D = get_slide_collision(colcount-1)
		velocity = velocity.bounce(col.get_normal())
		maxbounces -= 1
		if maxbounces == -1:
			queue_free()
	
		
	
	
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
