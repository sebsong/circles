extends Node2D

signal all_enemies_killed

func _ready():
	var _error = connect("all_enemies_killed", $"/root/LevelManager", "_on_EnemySpawner_all_enemies_killed")

func _process(_delta):
	if $EnemySpawner.get_child_count() == 0:
		emit_signal("all_enemies_killed")
