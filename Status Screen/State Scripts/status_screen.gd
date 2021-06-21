extends Control

signal setting_changed

var turret_settings_array = ["auto_remote", "safe", "auto", "soft", "bio", "multi_spec"]
var time = 0
var time2 = 0
onready var worldnode = get_node("..")
var rng = RandomNumberGenerator.new()

func _ready():
	self._get_settings()
	rng.randomize()
	
func _physics_process(delta):
	if self.is_visible_in_tree():
		aliens_at_the_door(delta)
	elif worldnode.game_over && worldnode.game_win != true:
		aliens_at_the_door(delta)
	else:
		return

func aliens_at_the_door(delta):	
	if worldnode.range_gauge.value == 0:
		if get_node("../alien_bang").is_playing():
			pass
		else:
			time += delta
			var randdelay = rng.randf_range(1.5, 3.0)
			if time > randdelay:
				worldnode.play_alien_bangs()
				time = 0
			else:
				pass
		if get_node("../alien_growl").is_playing():
			pass
		else:
			time2 += delta
			var randdelay = rng.randf_range(3.0, 5.0)
			if time2 > randdelay:
				#worldnode.play_alien_growls()
				time2 = 0
	else:
		return

func _get_settings():
	turret_settings_array.clear()
	for node in $config_settings.get_children():
		var state = node._get_state()
		turret_settings_array.append(state)
	emit_signal("setting_changed")
	
func _serve_settings():
	return turret_settings_array

