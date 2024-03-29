extends CharacterBody2D
@onready var agent =$NavigationAgent2D
@onready var timer =$NavigationAgent2D/Timer
var target:CharacterBody2D
@export var speed:int
var seen:bool = false
var external = Vector2.ZERO

var deltae
func _ready():
	timer.connect("timeout",_update_path)

func _update_path() -> void:
	if target:
		agent.target_position = target.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	deltae = delta
	if !is_instance_valid(Global.player):
		return
	if !target:
		target = Global.player
		_update_path()
	var dir = global_position.direction_to(agent.get_next_path_position())
	if dir.length()>0.5:
		velocity = velocity.move_toward(dir*speed,speed*delta)
	if seen == true:

		velocity = (velocity+external).clamp(Vector2(-1,-1)*speed, Vector2(1,1)*speed)
	
		move_and_slide()
		external = external.move_toward(Vector2.ZERO,(speed**1.75)*delta)
		
	else:
		$Sprite2D.flip_h = dir.x <0
		return
	if velocity and $hitbox.health >= 0 :
		$Sprite2D.flip_h = velocity.x <0
		$AnimationPlayer.play("run")

	$attack.look_at(Global.player.position)
	

func _on_visible_on_screen_enabler_2d_screen_entered():
	$AnimationPlayer.play_backwards("death")
	$Sprite2D.show()
	
	await $AnimationPlayer.animation_finished
	$Label.show()
	seen = true


func _on_attack_area_entered(area):
	if area.get_parent().name == "player":
		external = -velocity.normalized()*speed
		
