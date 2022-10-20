extends "res://Enemy/Enemy.gd"

var Enemy : PackedScene = preload("res://Enemy/Enemy.tscn")

func _ready():
	add_to_group("BounceEnemies")

func _process(_delta):
	pass

func _die():
	queue_free()
