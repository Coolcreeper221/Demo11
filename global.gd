extends Node
const FILE_NAME = "res://mods/items.res"
@export var items:Array[Item]
@export var player:CharacterBody2D
@export var shake:float
@export var ammo:int = 10
@export var ammo_timer:float
@export var ammo_cooldown:float
@export var clearedrooms:Array
var applied = false
func _ready() -> void:
	var item_saver = item_saver.new()
	item_saver.items = items
	ResourceSaver.save(item_saver, "res://mods/items.res")
	
	_updateitem(1,0)
func _updateitem(i:int,id:int):
	
	var file = ResourceLoader.load("res://mods/items.res")
	var list:Array=file.items
	
	print(list)
	items[i] = list[id]
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
		for item in items:
			player.SPEED += item.SPEED
			player.cooldown += item.cooldown
			if item.pattern:
				player.pattern = item.pattern
			player.bspeed += item.bspeed
			player.maxbounces += item.maxbounces
			if item.curve:
				player.curve = item.curve
			if item.curveloop:
				player.curveloop = item.curveloop
			if item.homing:
				player.homing = item.homing
			player.maxhealth += item.maxhealth



