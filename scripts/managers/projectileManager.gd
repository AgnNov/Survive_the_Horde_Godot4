class_name ProjectileManager
extends Node

@export var projectile_scene : PackedScene

func _on_player_attack(position, attack_direction):
	var projectile : Projectile = projectile_scene.instantiate()
	projectile.add_to_group("projectiles")
	add_child(projectile)

	projectile.position = position
	projectile.direction = attack_direction.normalized()



