extends Control



onready var sysmode_state = $weapstat_states/safe
onready var next_sysmode_state = $weapstat_states/armed

var current_state_set = "safe"

func _ready():
	$BTN_WEAPON_STATUS.connect("pressed", self, "_change_state")
	sysmode_state.enter()
	
func _process(delta):
	sysmode_state._update()

func _change_state():
	sysmode_state.exit()
	sysmode_state = next_sysmode_state
	sysmode_state.enter()
	if sysmode_state == $weapstat_states/safe:
		current_state_set = "safe"
		next_sysmode_state = $weapstat_states/armed
	else:
		current_state_set = "armed"
		next_sysmode_state = $weapstat_states/safe
	var status_screen = get_node("../..")
	status_screen._get_settings()

func _get_state():
	return current_state_set
