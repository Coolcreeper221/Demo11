extends Area2D

@export var health = 1



func _on_body_entered(body):
	if body.name.contains("Bullet"):
		health-=1
		body.queue_free()
		_hit()
	if health <0:
		$"..".call_deferred("set_process_mode",Node.PROCESS_MODE_DISABLED)
		$"../AnimationPlayer".play("death")
		await $"../AnimationPlayer".animation_finished 
		$"..".queue_free()
	
func _hit():
	$AnimationPlayer.play("modulate")
	Engine.set_time_scale(.1)
	await get_tree().create_timer(.005).timeout
	Engine.set_time_scale(1)
	
