class_name Enemy
extends Area2D

var speed : float = 90.0

var is_player_reached : bool = false
var player_position : Vector2
var target_direction : Vector2


@onready var player : Player = $"/root/game/Player"
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var timer : Timer = $Timer

signal player_reached

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	player_reached.connect(player._on_enemy_player_reached)

func _physics_process(delta):
	if not is_player_reached:
		player_position = player.position
		target_direction = (player_position - position).normalized()
		
		position += target_direction * speed * delta
		# TO DO: avoid teleporting on top of each other
	else:
		speed = 0.0

func _on_body_entered(body):
	if body.is_in_group("player"):
		is_player_reached = true

	animated_sprite.play("dying")
	timer.start()
	
func _on_area_entered(area):
	if area.is_in_group("projectiles"):
		speed = 0.0
		area.queue_free()
		animated_sprite.play("dying")
		timer.start()
		
func _on_timer_timeout():
	if is_player_reached:
		player_reached.emit()
		
	queue_free()
