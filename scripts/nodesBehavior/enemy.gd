class_name Enemy
extends CharacterBody2D

var speed : float = 90.0
var player_position : Vector2
var target_direction : Vector2

@onready var player : Player = $"/root/game/Player"
@onready var audio_stream_player = $AudioStreamPlayer2D

func _physics_process(delta):
	player_position = player.position
	target_direction = (player_position - position).normalized()
	
	velocity = target_direction * speed
	move_and_slide()
	#
func _on_enemy_area_shooted():
	audio_stream_player.play()
	speed = 0.0
