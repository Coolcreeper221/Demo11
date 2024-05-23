extends Node

@export var items:Array[item]
@export var player:CharacterBody2D
@export var shake:float
@export var ammo:int = 10
@export var ammo_timer:float
@export var ammo_cooldown:float
@export var clearedrooms:Array
var applied = false
func _process(delta):
	
	ammo_timer += delta
	if ammo_timer >= ammo_cooldown:
		ammo_timer = 0 
		ammo +=1 
	shake = clamp(shake,0,0.05)
	if shake:
		var cam = player.find_child("Camera2D")
		randomize()
		var dir = Vector2(randf_range(-1,1),randf_range(-1,1))
		cam.offset = dir*shake*100
		shake=move_toward(shake,0,delta)
		
	if is_instance_valid(player) and !applied:
		applied = true
		for Item in items:
			player.SPEED += Item.SPEED
			player.cooldown += Item.cooldown
			if Item.pattern:
				player.pattern = Item.pattern
			player.bspeed += Item.bspeed
			player.maxbounces += Item.maxbounces
			if Item.curve:
				player.curve = Item.curve
			if Item.curveloop:
				player.curveloop = Item.curveloop
			if Item.homing:
				player.homing = Item.homing
			player.maxhealth += Item.maxhealth



