class_name EnemyArea
extends Area2D

var speed : float = 90.0

var player_position : Vector2
var target_direction : Vector2
var is_player_reached : bool = false
var is_shootable : bool = true

@onready var player : Player = $"/root/game/Player"
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var timer : Timer = $"../Timer"
@onready var enemy_parent : Enemy = $".."
@onready var labels = %Labels

signal player_reached
signal shooted

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	player_reached.connect(player._on_enemy_player_reached)
	shooted.connect(enemy_parent._on_enemy_area_shooted)
	shooted.connect(labels._on_enemy_area_shooted)

func _on_body_entered(body):
	if body.is_in_group("player"):
		is_player_reached = true

	animated_sprite.play("dying")
	timer.start()
	
func _on_area_entered(area):
	if area.is_in_group("projectiles"):
		if is_shootable:
			shooted.emit()
			is_shootable = false
			
		area.queue_free()
		animated_sprite.play("dying")
		timer.start()
		
func _on_timer_timeout():
	if is_player_reached:
		player_reached.emit()
		
	enemy_parent.queue_free()
