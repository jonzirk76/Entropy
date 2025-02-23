extends CharacterBody2D

@export var speed := 10
@export var margin := 110

@onready var screen_size := get_viewport_rect().size
@onready var upper_left := Vector2(margin,margin)

func _ready() -> void:
	screen_size.x -= margin
	screen_size.y -= margin

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	position += velocity * speed * delta
	position = position.clamp(upper_left, screen_size)
