class_name Enemy
extends Area2D

var speed : float = 90.0

var player_position : Vector2
var target_direction : Vector2
var is_player_reached : bool = false

@onready var player = $"/root/game/Player"
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer

signal player_reached

func _physics_process(delta):
	player_position = player.position
	target_direction = (player_position - position).normalized()
	
	position += target_direction * speed * delta
	# avoid teleporting on top of each other

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

func _on_rigid_body_2d_body_entered(body):
	if body.is_in_group("player"):
		is_player_reached = true

	animated_sprite.play("dying")
	timer.start()
