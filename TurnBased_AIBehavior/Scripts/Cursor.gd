class_name Cursor
extends Node2D

@onready var _timer: Timer = $Timer
@onready var _sprite: Sprite2D = $Sprite2D
#Emitted ketika melakukan click pada cell yang sedang ditunjuk
signal accept_pressed(cell)
#Emitted ketika kursor bergerak ke cell baru
signal moved(new_cell)
#Waktu sebelum mouse dapat berpindah lagi
@export var cursor_ui_cooldown := 0.1

#Menentukan koordinat cell yg ditunjuk atau (hovered) by cursor
var is_within_map: bool

### PR BENARKAN CURSOR LOCATOR SESUAIKAN DENGAN TILEMAP### ->> DONE [v]
var cell := Vector2.ZERO:
	set(value):
		var new_cell: Vector2 = map.local_to_map(get_global_mouse_position())
		
		cell = new_cell
		position = map.map_to_local(cell)
		_check_hoverable_tiles()
		emit_signal("moved", cell)
		_timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	_timer.wait_time = cursor_ui_cooldown
	position = map.local_to_map(cell)

func _unhandled_input(event: InputEvent) -> void:
	# Navigating cells with the mouse (update cell baed on hovered mouse).
	if event is InputEventMouseMotion:
		cell = map.local_to_map(event.position)
	# Trying to select something in a cell.
	elif event.is_action_pressed("click") or event.is_action_pressed("ui_accept"):
		print(cell)
		emit_signal("accept_pressed", cell)
		get_viewport().set_input_as_handled()

	var should_move := event.is_pressed() 
	if event.is_echo():
		should_move = should_move and _timer.is_stopped()

	if not should_move:
		return
# Called every frame. 'delta' is the elapsed time since the previous frame.
