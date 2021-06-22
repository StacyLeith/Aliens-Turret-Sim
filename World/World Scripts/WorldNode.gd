extends Node2D

# setting format [auto_remote, safe, auto, soft, bio, multi_spec]


signal update_ready

# Stuff for settings


var target_spawned_max = 2
var aliens_to_spawn
var spawn_chance = 50

# Other vars
var wiggle = false
var hit_chance_range # 50
var lock_chance_range # 50
var sensor_multiplier # 1

var target_spawn_delay = 1
var turret_settings_array = []
var rng = RandomNumberGenerator.new()
onready var gun_shot_player = $gun_shot_player
onready var console_beeps = $console_beeps
onready var crit_drone = $crit_drone
onready var crit_warning = get_node("fire_screen/crit_warning")
onready var alien_scream = get_node("alien_scream")
onready var alien_bang = get_node("alien_bang")
onready var alien_growl = get_node("alien_growl")
onready var time_counter = get_node("fire_screen/time_counter")
onready var range_gauge = get_node("fire_screen/r_guage")
onready var settings = get_node("settings")
var time = 0
var time2 = 0
var flash_time = 0.75
var crit_beep_delay = 0.38
var game_over = false
var game_win = false



var time_since_last_spawn = 0
var last_scream
var last_bang
var last_growl

var aliens_spawned = 0
var targets_left



func _ready():
	$status_screen.connect("setting_changed", self, "_update_settings")
	$death_delay.connect("timeout", self, "death_screen")
	console_beeps.stream = preload("res://Sounds/console_beep.wav")
	$crit_beep.stream = preload("res://Sounds/crit_beep.wav")
	$targets.spawn_target()
	_update_settings()
	rng.randomize()


func _physics_process(delta):

	if settings.in_settings:
		return
	else:
		
		flash_alarm_light(delta)
		if not $gameplay_script.system_safe && not game_over:
			
			crit_check(delta)
			add_targets(delta)
		
		elif game_win == false && game_over:
			
			play_crit_drone()
			if targets_left != 0 && $gameplay_script.selected_target != null:
				range_gauge.value = $targets.get_child($gameplay_script.selected_target).target_range()
			else:
				range_gauge.value = 0
			if range_gauge.value == 0:
				game_over_man(delta, $gameplay_script.remaining_rounds, null)
				$death_shader.visible = true
				wiggle = true
				if $death_delay.is_stopped():
					$death_delay.start()
				
			else:
				return
			
		elif game_win:
			#print("moo to you")
			game_over_man(delta, $gameplay_script.remaining_rounds, null)
			if $win_delay.is_stopped():
				$win_delay.start()
		else:
			return

func death_screen():
		$death_shader.visible = false
		$status_screen.visible = false
		$fire_screen.visible = false
		$death_screen.visible = true

		
func turret_settings():
	_update_settings()
	var selected_settings = []
	match str(turret_settings_array[3]):
		"soft":
			hit_chance_range = 100 # hitchance 100
			selected_settings.append(hit_chance_range)
		"semihard":
			hit_chance_range = 75 # hitchance 75
			selected_settings.append(hit_chance_range)
		"hard":
			hit_chance_range = 50 # hitchance 50
			selected_settings.append(hit_chance_range)
	match str(turret_settings_array[4]):
		"bio": 
			lock_chance_range = 50 # lock chance 50
			selected_settings.append(lock_chance_range)
		"inert":
			lock_chance_range = 75 # lock chance 75
			selected_settings.append(lock_chance_range)
	match str(turret_settings_array[5]):
		"multi_spec":
			sensor_multiplier = 1# sensor multi 1
			selected_settings.append(sensor_multiplier)
		"infra_red":
			sensor_multiplier = 3 #sensor 3
			selected_settings.append(sensor_multiplier)
		"uv":
			sensor_multiplier = 1.25 # sensor 1.25
			selected_settings.append(sensor_multiplier)
	return selected_settings

	# setting format [auto_remote, safe, auto, soft, bio, multi_spec]
		
func print_stats():
	var stats = "[center]Kills: " + str($gameplay_script.kills) + "\nShots fired: " + str($gameplay_script.shoots_fired) + "\nAccuracy: " + str($gameplay_script.get_accuracy()) + "%\nGun destroyed: " + $gameplay_script.is_gun_destroyed() + "[/center]"
	return stats
	
func crit_check(delta):
	if $gameplay_script.remaining_rounds <= 50:
		play_crit_beep(delta)
		crit_warning.playing = true
		crit_warning.visible = true
	
func serve_targets():
	var targets_info = 0
	targets_info = $targets.get_child_count()
	if targets_info >= 1:
		return targets_info
		
	else:
		return 0
		
func game_over_man(delta, remaining_rounds, selected_target):
	#print("here")
	if remaining_rounds <= 0:
		stop_crit_beep()
		crit_warning.stop()
		crit_warning.frame = 1
		play_crit_drone()
		game_over = true
		time_counter.change_displayed_time(00.00)
		if targets_left != 0 && selected_target != null:
			range_gauge.value = $targets.get_child(selected_target).target_range()
		else:
			range_gauge.value = 0
		if range_gauge.value == 0:
			$gameplay_script.gun_destroyed = true
			if $death_delay.is_stopped():
				$death_delay.start()
			
	elif not game_win:	
		game_over = true
		play_crit_beep(delta)
		range_gauge.value = 0
		$gameplay_script.system_safe = true
		if targets_left != 0 && selected_target != null:
			range_gauge.value = $targets.get_child(selected_target).target_range()
		else:
			range_gauge.value = 0
		if range_gauge.value == 0:
			$gameplay_script.gun_destroyed = true
			if $death_delay.is_stopped():
				$death_delay.start()
	else:
		return
	
	
func add_targets(delta):	
	if aliens_spawned < aliens_to_spawn:
		time_since_last_spawn += delta
		if time_since_last_spawn > target_spawn_delay:		
			var spawn = rng.randi_range(0, 100)
			if spawn <= spawn_chance:
				var baddies = rng.randi_range(1, target_spawned_max)
				for i in baddies:
					$targets.spawn_target()
					aliens_spawned += 1
				time_since_last_spawn = 0
				targets_left = aliens_to_spawn - aliens_spawned
			else:
				time_since_last_spawn = 0
		else:
			return
	elif $gameplay_script.kills == aliens_to_spawn:
		game_over = true
		game_win = true
	
	
func armed_screen_switch():
	yield(get_tree().create_timer(0.5), "timeout")
	$status_screen.visible = false
	$fire_screen.visible = true

func _update_settings():
	turret_settings_array = $status_screen._serve_settings()
	emit_signal("update_ready")

func play_gun_shot():
	gun_shot_player.stream = preload("res://Sounds/gun_shot.wav")
	var pitch = rng.randf_range(0.9, 1.0)
	gun_shot_player.pitch_scale = pitch
	gun_shot_player.play()
	gun_shot_player.pitch_scale = 1

func play_alien_bangs():
	var rand_bang = rng.randi_range(1, 5)
	while rand_bang == last_bang:
		rand_bang = rng.randi_range(1, 5)
	match str(rand_bang):
		"1":
			alien_bang.stream = preload("res://Sounds/alien_banging1.wav")
		"2":
			alien_bang.stream = preload("res://Sounds/alien_banging2.wav")
		"3":
			alien_bang.stream = preload("res://Sounds/alien_banging3.wav")
		"4":
			alien_bang.stream = preload("res://Sounds/alien_banging4.wav")
		"5":
			alien_bang.stream = preload("res://Sounds/alien_banging5.wav")
	alien_bang.play()
	last_bang = rand_bang
	
func play_alien_growls():
	var rand_growl = rng.randi_range(1, 3)
	while rand_growl == last_growl:
		rand_growl = rng.randi_range(1, 3)
	match str(rand_growl):
		"1":
			alien_growl.stream = preload("res://Sounds/alien_growl1.wav")
		"2":
			alien_growl.stream = preload("res://Sounds/alien_growl2.wav")
		"3":
			alien_growl.stream = preload("res://Sounds/alien_growl3.wav")
	alien_growl.play()
	last_growl = rand_growl
			
func play_alien_scream():
	var rand_scream = rng.randi_range(1, 7)
	while rand_scream == last_scream:
		rand_scream = rng.randi_range(1, 7)
	match str(rand_scream):
		"1":
			alien_scream.stream = preload("res://Sounds/alien_scream1.wav")
		"2":
			alien_scream.stream = preload("res://Sounds/alien_scream5.wav")
		"3":
			alien_scream.stream = preload("res://Sounds/alien_scream9.wav")
		"4":
			alien_scream.stream = preload("res://Sounds/alien_scream10.wav")
		"5":
			alien_scream.stream = preload("res://Sounds/alien_scream13.wav")
		"6":
			alien_scream.stream = preload("res://Sounds/alien_scream14.wav")
		"7":
			alien_scream.stream = preload("res://Sounds/alien_scream19.wav")
	alien_scream.play()
	last_scream = rand_scream
	

func play_beep():
		console_beeps.play()
	
func play_crit_beep(delta):
	if crit_warning.is_visible_in_tree():
		time2 += delta
		if time2 > crit_beep_delay:
			time2 = 0
			$crit_beep.play()
		else:
			return
	else:
		return
		
func stop_crit_beep():
	$crit_beep.stop()
	
func play_crit_drone():
	if $fire_screen.is_visible_in_tree():
		crit_drone.play()

func flash_alarm_light(delta):
	if not game_win && wiggle == false:
		time += delta
		if time > flash_time:
			time = 0
			if $alarm_light.is_visible_in_tree():
				$alarm_light.visible = false
			else:
				$alarm_light.visible = true
				$alarm_claxon.play()
		else:
			return
	else:
		$alarm_light.visible = false
