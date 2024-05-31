extends Resource
class_name Item

@export var Name:String
@export var SPEED = 0
@export var cooldown = 0
@export_category("Bullet Motion")
@export var pattern:PackedScene
@export var bspeed:float
@export var maxbounces:int
@export var curve:Curve
@export var curveloop:bool
@export_category("Bullet Homing")
@export var homing:bool
@export_category("Health")
@export var maxhealth:int = 0
@export var health = maxhealth
@export var sprite_index = 0
@export var texture:CompressedTexture2D
