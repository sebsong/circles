extends Label

func _process(_delta):
	if get_parent().is_queued_for_deletion():
		var _error = get_tree().change_scene("res://Main.tscn")
