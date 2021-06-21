extends Control

var played = false

func _physics_process(delta):
	if self.is_visible_in_tree():
		if played == false:
			get_node("../game_over").play()
			played = true
		else:
			if get_node("../game_over").is_playing():
				return
			else:
				self.get_parent().get_tree().reload_current_scene()
	else:
		return
