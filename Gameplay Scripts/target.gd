extends Node2D

# Things for settings

var hit_chance_range
var lock_chance_range
var sensor_multiplier

# Other vars 

var hitpoints = 5
var alive = true
var hit_chance
var lock_chance

var rng = RandomNumberGenerator.new()
var target_range

func _ready():
	rng.randomize()
	target_range = rng.randi_range(50, 100)
	take_setting_stats()
	

func _physics_process(delta):
	target_range -= 0.2
	take_setting_stats()

func take_setting_stats():
	var set_array = get_node("../..").turret_settings()
	hit_chance_range = set_array[0]
	lock_chance_range = set_array[1]
	sensor_multiplier = set_array[2]


func target_range():
	return target_range

func calc_advantage():
	if target_range >= 75:
		pass
	elif target_range >= 50:
		hit_chance_range -= 5
	elif target_range >= 25:
		hit_chance_range -= 8 
	else:
		hit_chance_range -= 1 
	
	if hitpoints >= 3:
		pass
	elif hitpoints >= 2:
		hit_chance_range -= 15 
	else:
		hit_chance_range -= 30
	
func check_alive():
	if hitpoints <= 0:
		alive = false
	else:
		return true

func take_damage():
	rng.randomize()
	calc_advantage()
	hit_chance = rng.randi_range(1, hit_chance_range)	
	if rng.randi_range(1, 50) > hit_chance * sensor_multiplier:
		hitpoints -= 1
	else:
		return

func attempt_lock():
	rng.randomize()
	calc_advantage()
	lock_chance = rng.randi_range(1, lock_chance_range)
	if rng.randi_range(1, 50) > lock_chance * sensor_multiplier:
		return true
	else:
		return false
