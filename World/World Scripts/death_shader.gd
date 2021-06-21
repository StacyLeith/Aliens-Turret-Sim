extends ColorRect

func _process(delta):
	if self.is_visible_in_tree():
		self.shake_power += 0.1
