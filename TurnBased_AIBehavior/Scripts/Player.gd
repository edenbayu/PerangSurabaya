extends CharacterBody2D

@onready var _sprite = $Sprite2D

@export var skin: Texture:
	set(value):
		skin = value
		if not _sprite:
			await ready
		_sprite.texture = value
#setter getter

@export var util: Resource

@export var health: int:
	set(value):
		health = value
		if util.unit_name == "Soerjo":
			value += util.unit_level * 50

func _ready():
	print(health)

func _process(delta):
	pass
