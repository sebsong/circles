extends KinematicBody2D

const MAX_POWER : float = 15.0
const CHARGE_SECONDS : int = 1
const ARROW_SCALE_ADJUST : int = 100
const STOPPED_THRESHOLD : float = 0.5
const VELOCITY_DECAY_PERCENTAGE : float = 0.99

var power : float = 0.0
var velocity : Vector2 = Vector2.ZERO
var is_charging : bool = false
var is_stopped : bool = false
var shots_left = get_num_shots()

func _process(delta):
	if velocity.length() < STOPPED_THRESHOLD:
		velocity = Vector2.ZERO

	is_stopped = velocity.length() == 0
	
	if is_stopped:
		if shots_left == 0:
			LevelManager.game_over()
		
		if Input.is_mouse_button_pressed(1):
			is_charging = true
			power += (MAX_POWER / CHARGE_SECONDS) * delta
			power = min(power, MAX_POWER)
		elif power > 0:
			is_charging = false
			fire_circle()
			power = 0
	
	var collision = move_and_collide(velocity)
	if collision:
		handle_collision(collision)
	var decayed_velocity_length = velocity.length() - (velocity.length() * VELOCITY_DECAY_PERCENTAGE * delta)
	velocity = velocity.normalized() * decayed_velocity_length

	position_arrow()
	$Arrow.visible = is_stopped
	
	$ShotsLeftLabel.text = String(shots_left)

func handle_collision(collision : KinematicCollision2D):
	if collision.collider.has_method("hit"):
		collision.collider.hit()
	velocity = velocity.bounce(collision.normal)
	if collision.collider.is_in_group("BounceEnemies"):
		velocity = velocity.normalized() * MAX_POWER
	
func position_arrow():
	var arrow = $Arrow
	var mouse_position = get_viewport().get_mouse_position()

	var translation_amount = arrow.texture.get_width() / 2
	arrow.position = ((mouse_position - position).normalized() * translation_amount / 15)
	arrow.look_at(mouse_position + (mouse_position - position).normalized() * translation_amount)
	
func fire_circle():
	var mouse_position = get_viewport().get_mouse_position()
	velocity = (mouse_position - position).normalized() * power
	shots_left -= 1
	
func get_num_shots():
	return (LevelManager.level / 2) + 2
