class_name GameManager
extends Node

const ADDED_TIME : float = 2.0

var current_wait : float = 5.0
var time_passed_part : float
var timer_bar_width : float

@onready var player : Player = $"/root/game/Player"
@onready var labels = %Labels
@onready var timer : Timer = $Timer
@onready var timer_bar : Sprite2D = %TimerBar
@onready var game_over_panel : Node2D = %GameOverPanel

signal level_completed

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.timeout.connect(labels._on_timer_timeout)
	player.death.connect(_on_player_death)
	
	game_over_panel.visible = false
	timer_bar_width = timer_bar.scale.x
	timer.wait_time  = current_wait
	timer.start()

func _process(delta):
	time_passed_part = timer.get_time_left()/current_wait
	timer_bar.scale.x = timer_bar_width * time_passed_part

func _on_timer_timeout():
	current_wait = current_wait + ADDED_TIME
	timer.wait_time = current_wait
	level_completed.emit()
	timer.start()

func _on_player_death():
	Engine.time_scale = 0
	game_over_panel.visible = true

func _on_restart_button_pressed():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
