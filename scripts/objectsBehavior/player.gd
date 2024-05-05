class_name Player
extends CharacterBody2D

var speed = 180.0
var is_dying: bool = false
var attack_direction : Vector2

@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer

signal attack
signal death

func _ready():
	add_to_group("player")

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction == Vector2(0, 0) and not is_dying:
		animated_sprite.play("idle")
	else:
		if not is_dying:
			animated_sprite.play("running")
		
		if direction.x > 0:
			animated_sprite.flip_h = false
		elif direction.x < 0:
			animated_sprite.flip_h = true

	velocity = direction * speed
	
	if Input.is_action_just_pressed("attack"):
		attack_direction = get_global_mouse_position() - position
		animated_sprite.play("attacking")
		
		attack.emit(position, attack_direction)

func _physics_process(delta):
	get_input()
	move_and_slide()
	
func _on_enemy_player_reached():
	speed = 0.0
	is_dying = true
	
	animated_sprite.play("dying")
	timer.start()

func _on_timer_timeout():
	queue_free()
	death.emit()
