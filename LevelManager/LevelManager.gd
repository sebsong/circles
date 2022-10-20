extends Node2D

var level = 1

func _ready():
	pass

func _process(_delta):
	pass
	
func _on_EnemySpawner_all_enemies_killed():
	level += 1
	var _error = get_tree().change_scene("res://Main.tscn")

func game_over():
	var _error = get_tree().change_scene("res://Menu.tscn")
	LevelManager.level = 1

