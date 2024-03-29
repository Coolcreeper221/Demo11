extends Area2D

@export var health = 1
@export var player = false
func _on_area_entered(body):
	if player and !body.player:
		health-=1
		if body.name.contains("Bullet"):
			body.queue_free()
		_hit()
	
	elif body.name.contains("Bullet") and  get_parent().is_in_group("enemy"):
		health-=1
		if body.name.contains("Bullet"):
			body.queue_free()
		_hit()
	if health <0:
		$"..".call_deferred("set_process_mode",Node.PROCESS_MODE_DISABLED)
		$"../AnimationPlayer".stop()
		$"../AnimationPlayer".play("death")
		await $"../AnimationPlayer".animation_finished 
		$"..".queue_free()
func _on_body_entered(body):
	if player and !body.player:
		health-=1
		if body.name.contains("Bullet"):
			body.queue_free()
		_hit()
	
	elif body.name.contains("Bullet") and  get_parent().is_in_group("enemy"):
		health-=1
		if body.name.contains("Bullet"):
			body.queue_free()
		_hit()
	if health <0:
		$"..".call_deferred("set_process_mode",Node.PROCESS_MODE_DISABLED)
		$"../AnimationPlayer".stop()
		$"../AnimationPlayer".play("death")
		await $"../AnimationPlayer".animation_finished 
		$"..".queue_free()
	
func _hit():
	$AnimationPlayer.play("modulate")
	Engine.set_time_scale(.1)
	await get_tree().create_timer(.005).timeout
	Engine.set_time_scale(1)
	Global.shake += .1
	
