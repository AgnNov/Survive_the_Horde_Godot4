class_name Projectile
extends Area2D

const SPEED : float = 360.0

var direction : Vector2

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer2D

func _ready():
	audio_stream_player.play()
	
func _process(delta):
	animated_sprite.rotate(0.3)
	position += direction * SPEED * delta
