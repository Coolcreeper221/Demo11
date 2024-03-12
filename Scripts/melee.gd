extends CharacterBody2D
@onready var agent =$NavigationAgent2D
@onready var timer =$NavigationAgent2D/Timer
var target:CharacterBody2D
@export var speed:int
var seen:bool = false

func _ready():
	timer.connect("timeout",_update_path)

func _update_path() -> void:
	if target:
		agent.target_position = target.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !target:
		target = Global.player
		_update_path()
	var dir = global_position.direction_to(agent.get_next_path_position())
	if dir.length()>0.5:
		velocity = velocity.move_toward(dir*speed,delta*4*speed)
	if seen == true:
		move_and_slide()
		
	else:
		$Sprite2D.flip_h = dir.x <0
		return
	if velocity:
		$Sprite2D.flip_h = velocity.x <0
		$AnimationPlayer.play("run")
	
	


func _on_visible_on_screen_enabler_2d_screen_entered():
	$AnimationPlayer.play_backwards("death")
	$Sprite2D.show()
	
	await $AnimationPlayer.animation_finished
	$Label.show()
	seen = true
