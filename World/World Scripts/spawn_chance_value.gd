extends RichTextLabel

onready var slider = get_node("../../slider/spawn_chance_slider")

func _process(delta):
	if slider.is_visible_in_tree():
		self.text = str(slider.value)
	else:
		return

