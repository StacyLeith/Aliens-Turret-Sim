extends Node2D

# Stuff for settings
var remaining_rounds = 500

# Stuff for end screen
var kills = 0
var shoots_fired = 0
var session_time

var turret_settings_array
var system_safe = true

var wait_between_shots = 0.0666666
var time = 0
var time2 = 0
var cooling_time = 0.01
var add_gun_temp = 1.5
var lose_gun_temp = 0.25
var rng = RandomNumberGenerator.new()
var time_at_100 = 0.00
var gun_temp = 0

var gun_destroyed = false
var locked_target = false
var selected_target

onready var worldnode = get_node("..")
onready var counter = get_node("../fire_screen/rounds_counter")
onready var temp_gauge = get_node("../fire_screen/temp_gauge_bar")
onready var crit_warning = get_node("../fire_screen/crit_warning")
onready var time_counter = get_node("../fire_screen/time_counter")
onready var targets = get_node("../targets")
onready var range_gauge = get_node("../fire_screen/r_guage")
#onready var got_lock = get_node("../got_lock")
onready var settings = get_node("../settings")

func _ready():
	time_at_100 = remaining_rounds * wait_between_shots
	worldnode.connect("update_ready", self, "update_settings")
	counter.change_displayed_rounds(remaining_rounds)
	time_counter.change_displayed_time(time_at_100)
	rng.randomize()

func _physics_process(delta):
	if settings.in_settings:
		return
	else:
		gun_cooling(delta)
		time_counter.change_displayed_time(time_at_100)
		if remaining_rounds != 0 && gun_destroyed != true:
			if not system_safe:
				if locked_target:
					fire_routine(delta)
				else:
					aquire_target()
			else:
				return
		else:
			if worldnode.game_over:
				return
			else:
				worldnode.game_over_man(delta, remaining_rounds, selected_target)
				worldnode.print_stats()

func is_gun_destroyed():
		if gun_destroyed:
			return "Yes"
		else:
			return "No"


func get_accuracy():
	if kills > 0:
		var accuracy = 0.0
		var bullet_kills = kills * 5
		accuracy = float(bullet_kills) / float(shoots_fired) 
		accuracy = accuracy * 100
		return stepify(accuracy, 0.01)
	else:
		return 0
	
func aquire_target():
	counter.change_displayed_rounds(remaining_rounds)
	if locked_target == false:
		var range_array = []
		var target_array = []
		var target_info = targets.get_child_count() - 1
		if target_info > 0:
			for i in target_info:
				range_array.append(targets.get_child(i).target_range)
			selected_target = range_array.find(range_array.min()) + 1
			if targets.get_child(selected_target).attempt_lock():
				locked_target = true
			else:
				return
		else:
			return
			

	else:
		return

func fire_routine(delta):
	if locked_target:
		var closest_target = targets.get_child(selected_target).target_range()
		range_gauge.value = closest_target
		if closest_target <= 0:
			gun_destroyed = true
			return
		if not system_safe:	
			var fire = _shoot_cooldown(delta)
			if fire && gun_temp < 98:
				match str(worldnode.turret_settings_array[0]):
					"auto_remote":
						worldnode.play_gun_shot()
						gun_temp += add_gun_temp
						remaining_rounds -= 1
						shoots_fired += 1
						targets.get_child(selected_target).take_damage()
						counter.change_displayed_rounds(remaining_rounds)
						time_at_100 -= wait_between_shots				
						temp_gauge.value = gun_temp
						if not targets.get_child(selected_target).check_alive():
							targets.get_child(selected_target).queue_free()
							locked_target = false
							selected_target = null
							range_gauge.value = 0
							kills += 1
							worldnode.play_alien_scream()
						else:
							return
					"man_override":
						if Input.is_action_pressed("ui_accept"):
							worldnode.play_gun_shot()
							gun_temp += add_gun_temp
							remaining_rounds -= 1
							shoots_fired += 1
							targets.get_child(selected_target).take_damage()
							counter.change_displayed_rounds(remaining_rounds)
							time_at_100 -= wait_between_shots				
							temp_gauge.value = gun_temp
							if not targets.get_child(selected_target).check_alive():
								targets.get_child(selected_target).queue_free()
								locked_target = false
								selected_target = null
								range_gauge.value = 0
								kills += 1
								worldnode.play_alien_scream()
							else:
								return
						else:
							return
					"semi_auto":
						if rng.randi_range(0, 1) == 1:
							if Input.is_action_pressed("ui_accept"):
								worldnode.play_gun_shot()
								gun_temp += add_gun_temp
								remaining_rounds -= 1
								shoots_fired += 1
								targets.get_child(selected_target).take_damage()
								counter.change_displayed_rounds(remaining_rounds)
								time_at_100 -= wait_between_shots				
								temp_gauge.value = gun_temp
								if not targets.get_child(selected_target).check_alive():
									targets.get_child(selected_target).queue_free()
									locked_target = false
									selected_target = null
									range_gauge.value = 0
									kills += 1
									worldnode.play_alien_scream()
								else:
									return
							else:
								return
						else:
							worldnode.play_gun_shot()
							gun_temp += add_gun_temp
							remaining_rounds -= 1
							shoots_fired += 1
							targets.get_child(selected_target).take_damage()
							counter.change_displayed_rounds(remaining_rounds)
							time_at_100 -= wait_between_shots				
							temp_gauge.value = gun_temp
							if not targets.get_child(selected_target).check_alive():
								targets.get_child(selected_target).queue_free()
								locked_target = false
								selected_target = null
								range_gauge.value = 0
								kills += 1
								worldnode.play_alien_scream()
							else:
								return
				
			elif gun_temp >= 100:
				gun_temp = 100
				temp_gauge.value = gun_temp
			else:
				return
		else:
			return
	else:
		return
		
		
func gun_cooling(delta):
	time2 += delta
	if time2 > cooling_time:
		time2 = 0
		if gun_temp > 0:
			gun_temp -= lose_gun_temp
			temp_gauge.value = gun_temp
		else:
			temp_gauge.value = gun_temp

func update_settings():
	turret_settings_array = worldnode.turret_settings_array
	if turret_settings_array[1] == "armed" && worldnode.game_over == false:
		system_armed()

func system_armed():
	worldnode.armed_screen_switch()
	system_safe = false
	
func _shoot_cooldown(delta):	
	time += delta
	if time > wait_between_shots:
		time = 0
		return true
	else:
		return false
