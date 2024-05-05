class_name LevelLabel
extends StaticBody2D

var level_count : int = 1

@onready var label = $Label

func _on_timer_timeout():
	level_count = level_count + 1
	label.text = "LEVEL {level_count}".format({"level_count": level_count})
