extends Label


func _process(_delta):
	if get_parent().is_queued_for_deletion():
		get_tree().quit()
