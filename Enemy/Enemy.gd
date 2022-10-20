extends RigidBody2D

func _ready():
	add_to_group("Enemies")
	
func hit():
	die()
	
func die():
	queue_free()
