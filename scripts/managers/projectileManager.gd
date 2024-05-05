class_name ProjectileManager
extends Node

@export var projectile_scene : PackedScene

@onready var player : Player = $"/root/game/Player"

func _ready():
	player.attack.connect(_on_player_attack)

func _on_player_attack(position, attack_direction):
	var projectile : Projectile = projectile_scene.instantiate()
	projectile.add_to_group("projectiles")
	add_child(projectile)

	projectile.position = position
	projectile.direction = attack_direction.normalized()



