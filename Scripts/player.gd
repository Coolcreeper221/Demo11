extends CharacterBody2D

@export var spawner:Node2D

@export var SPEED = 300.0
@export var cooldown = 1.0
var pre_pos = Vector2.ZERO
var direction = Vector2.ZERO
var timer = 0.0

@export_category("Bullet Motion")
@export var pattern:PackedScene
@export var bspeed:float
@export var maxbounces:int
@export var curve:Curve
@export var curveloop:bool
@export_category("Bullet Homing")
@export var homing:bool
@export var player:bool
@export var target:Node2D
@export_category("Health")
@export var maxhealth:int = 8
@export var health = maxhealth

func _ready():
	Global.player = self
	$hitbox.health = maxhealth
func _physics_process(delta):
	health = $hitbox.health
	var inp_direction = Vector2(Input.get_axis("left", "right"),Input.get_axis("up","down")).normalized()

	if inp_direction:
		velocity= inp_direction*(SPEED+ delta*SPEED)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	direction = $Mouse.position
	if direction.x>0:
			$Body.scale.x = -1

	elif direction.x<0:
			$Body.scale.x = 1
	
	$Pivot.look_at(to_global(direction))
	if (pre_pos-position).length() >=0.5:
		
		$AnimationPlayer.play("Run", -1, velocity.length()/100)
		
	else:
		$AnimationPlayer.play("idle",-1,1)
		
	
	timer += delta
	
	if Input.is_action_pressed("click") and timer>= cooldown:
		spawner.spawn($Pivot/Arrow/nozzle,{"speed":bspeed,"bounces":maxbounces,"curve":curve,"curveloop":curveloop,"homing":homing,"target":target,"player":player},pattern)
		timer = 0
		Global.shake += .05
	
	
	
	
	pre_pos = position
	$Mouse.global_position = (get_global_mouse_position()-position).normalized()*4+global_position
	$Pivot/Circle.charge = clamp(timer/cooldown,0,1)
	$Pivot/Circle.queue_redraw()
	move_and_slide()
	
	


