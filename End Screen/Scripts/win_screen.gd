extends Control

onready var worldnode = get_node("..")
onready var wintimer = get_node("../win_delay")
onready var status_screen = get_node("../status_screen")
onready var fire_screen = get_node("../fire_screen")

func _ready():
	wintimer.connect("timeout", self, "display_win_screen")

func _input(event):
	if self.is_visible_in_tree():
		if event is InputEventKey and event.pressed:
			worldnode.get_tree().reload_current_scene()
		else:
			return
	else:
		return
	
func display_win_screen():
	print("here")
	status_screen.visible = false
	fire_screen.visible = false
	self.visible = true
	$win_game_stats.bbcode_text = worldnode.print_stats()
