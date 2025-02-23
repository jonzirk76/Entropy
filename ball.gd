extends RigidBody2D

@export var speed := 100

@onready var directions := {
	"left_up" : Vector2(-1, -1),
	"right_up" : Vector2(1, -1),
	"left_down" : Vector2(-1, 1),
	"right_down" : Vector2(1, 1)
}

@onready var initial_velocity

func _ready() -> void:
	_random_velocity()
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(linear_velocity * delta)
	if collision:
		linear_velocity = linear_velocity.bounce(collision.get_normal())
	
func _random_velocity():
	var initial_velocity = directions.values()[randi() % directions.size()]
	linear_velocity = initial_velocity * speed
