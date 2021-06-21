extends Button

onready var gameplay_script = get_node("../../gameplay_script")
onready var rounds_slider = get_node("../HBoxContainer/slider/rounds_slider")
onready var status_screen = get_node("../../status_screen")
onready var settings = get_node("..")
onready var worldnode = get_node("../..")
onready var alien_slider = get_node("../HBoxContainer/slider/aliens_slider")
onready var spawn_chance = get_node("../HBoxContainer/slider/spawn_chance_slider")

func _pressed():
	gameplay_script.remaining_rounds = rounds_slider.value
	worldnode.aliens_to_spawn = alien_slider.value
	worldnode.spawn_chance = spawn_chance.value
	status_screen.visible = true
	settings.visible = false
