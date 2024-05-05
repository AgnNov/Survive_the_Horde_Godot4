class_name Labels
extends Node

var level_count : int = 1
var score : int = 0

@onready var level_label = $levelLabel
@onready var score_label = $scoreLabel

func _on_timer_timeout():
	level_count = level_count + 1
	level_label.text = "LEVEL {level_count}".format({"level_count": level_count})

func _on_enemy_area_shooted():
	score = score + 10
	score_label.text = "Score: {score}".format({"score": score})
