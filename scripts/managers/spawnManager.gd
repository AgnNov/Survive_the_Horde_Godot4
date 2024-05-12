class_name SpawnManager
extends Node

@export var enemy_scene : PackedScene

const SPAWNS_ADDED = 4

var spawn_points : Array = []
var spawns_count : int = 1

func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
	
	for i in spawn_points:
		for j in range(0, spawns_count):
			var enemy : Enemy = enemy_scene.instantiate()
			add_child(enemy)
			enemy.position = i.position

func _on_game_manager_level_completed():
	spawns_count = spawns_count + SPAWNS_ADDED

	for i in spawn_points:
		for j in range(0, spawns_count):
			var enemy : Enemy = enemy_scene.instantiate()
			add_child(enemy)
			enemy.position = i.position 
			await get_tree().create_timer(0.1).timeout 
			


		
