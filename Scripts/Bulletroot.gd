extends Node2D

@export var points:Array[Dictionary]
@export var node:PackedScene
@export var input:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	if Engine.is_editor_hint():
		pass
	else: 
	
		for i in points:
			
			var bullet:Node2D = node.instantiate()
			input["pos"] += i["pos"].rotated(input["rot"])
			input["rot"] += i["rot"]
			input.merge(i)
			bullet.input = input
			
			get_parent().add_child(bullet,true)
		
		queue_free()

