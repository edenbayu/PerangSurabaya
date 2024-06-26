extends CharacterBody2D

const MOVEMENT_SPEED = 240.0

@onready var sprite := $Sprite2D as Sprite2D

func _process(_delta: float):
	velocity = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	if velocity.length_squared() > 1.0:
		velocity = velocity.normalized()
	velocity *= MOVEMENT_SPEED
	move_and_slide()


func _input(event: InputEvent):
	if event.is_action_pressed(&"move_left"):
		sprite.rotation = PI / 2
	elif event.is_action_pressed(&"move_right"):
		sprite.rotation = -PI / 2
	elif event.is_action_pressed(&"move_up"):
		sprite.rotation = PI
	elif event.is_action_pressed(&"move_down"):
		sprite.rotation = 0.0

