extends Control

var in_settings = true

func _process(delta):
	if self.is_visible_in_tree():
		in_settings = true
	else:
		in_settings = false
