extends Control

var played = false

onready var worldnode = get_node("..")

func _physics_process(delta):
	if worldnode.game_win == true:
		self.queue_free()
	else:
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
