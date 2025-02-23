extends Node

@export var ball_scene : PackedScene

var balls_to_win := 0
var balls_in_win_area := 0
var game_started := false

@onready var score = 0
@onready var balls = $Balls

func _ready() -> void:
	hide_walls()

func _process(delta: float) -> void:
	if balls_in_win_area == balls_to_win and game_started:
		win()

func _on_win_area_body_entered(body: Node2D) -> void:
	balls_in_win_area += 1

func _on_win_area_body_exited(body: Node2D) -> void:
	balls_in_win_area -= 1

func new_game():
	score = 0
	$StartTimer.start()
	$HUD/ScoreLabel.show()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	await $StartTimer.timeout
	
	make_balls()
	show_walls()
	game_started = true

func win():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	hide_walls()
	get_tree().call_group("ball", "queue_free")
	game_started = false

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()

func make_balls():
	for child in balls.get_children():
		if child is Marker2D:
			balls_to_win += 1
			var ball = ball_scene.instantiate()
			ball.position = child.position
			ball.process_mode = Node.PROCESS_MODE_INHERIT
			add_child(ball)

func hide_walls():
	$Wall.hide()
	$Wall.process_mode = Node.PROCESS_MODE_DISABLED
	$MovingWall.hide()
	$MovingWall.process_mode = Node.PROCESS_MODE_DISABLED
	
func show_walls():
	$Wall.show()
	$Wall.process_mode = Node.PROCESS_MODE_INHERIT
	$MovingWall.show()
	$MovingWall.process_mode = Node.PROCESS_MODE_INHERIT
