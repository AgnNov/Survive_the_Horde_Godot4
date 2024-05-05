class_name SpawnManager
extends Node

@export var enemy_scene : PackedScene

var spawn_points : Array = []
var spawns_count : int = 1

@onready var player = $"/root/game/Player"


func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
	
	for i in spawn_points:
		for j in range(0, spawns_count):
			var enemy : Enemy = enemy_scene.instantiate()
			enemy.player_reached.connect(player._on_enemy_player_reached)
			add_child(enemy)
			enemy.position = i.position

func _on_game_manager_level_completed():
	spawns_count = spawns_count + 2

	for i in spawn_points:
		for j in range(0, spawns_count):
			var enemy : Enemy = enemy_scene.instantiate()
			# connect signal to player
			enemy.player_reached.connect(player._on_enemy_player_reached)
			add_child(enemy)
			enemy.position = i.position 
			await get_tree().create_timer(0.1).timeout 
			# to replace with something that will cause enemies not to spawn on each other
			


		
