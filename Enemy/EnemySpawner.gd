extends Node2D

enum EnemyType {
	STANDARD,
	BOUNCE
}

var ENEMY_TYPE_TO_SCENE : Dictionary = {
	EnemyType.STANDARD : preload("res://Enemy/Enemy.tscn"),
	EnemyType.BOUNCE : preload("res://Enemy/BounceEnemy.tscn")
}

var rng = RandomNumberGenerator.new()
var min_x : float
var max_x : float
var min_y : float
var max_y : float

func _ready():
	rng.randomize()
	var viewport_rect : Rect2 = get_viewport_rect()
	min_x = viewport_rect.position.x
	max_x = viewport_rect.end.x
	min_y = viewport_rect.position.y
	max_y = viewport_rect.end.y
	
	for _i in LevelManager.level:
		var roll : int = rng.randi_range(0, 100)
		var bounce_roll_cutoff : int = LevelManager.level * 2
		if roll > bounce_roll_cutoff:
			spawn_enemy_random(EnemyType.STANDARD)
		else:
			spawn_enemy_random(EnemyType.BOUNCE)

func _process(_delta):
	for enemy in get_children():
		if enemy.is_queued_for_deletion() and enemy.is_in_group("BounceEnemies"):
			spawn_enemy(EnemyType.STANDARD, enemy.position)	

func _input(_event):
	if Input.is_action_pressed("spawn_enemy"):
		spawn_enemy_random(EnemyType.STANDARD)
	if Input.is_action_pressed("spawn_bounce_enemy"):
		spawn_enemy_random(EnemyType.BOUNCE)

func spawn_enemy_random(enemy_type : int):
	spawn_enemy(enemy_type, get_random_position())

func spawn_enemy(enemy_type : int, position : Vector2):
	var enemy = ENEMY_TYPE_TO_SCENE[enemy_type].instance()
	enemy.position = position
	add_child(enemy)

func get_random_position() -> Vector2:
	var rand_x = rng.randf_range(min_x, max_x)
	var rand_y = rng.randf_range(min_y, max_y)
	return Vector2(rand_x, rand_y)
