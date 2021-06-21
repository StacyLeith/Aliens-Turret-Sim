extends Control



onready var sysmode_state = $testrout_states/auto
onready var next_sysmode_state = $testrout_states/selective

var current_state_set = "auto"

func _ready():
	$BTN_TEST_ROUTINE.connect("pressed", self, "_change_state")
	sysmode_state.enter()
	
func _process(delta):
	sysmode_state._update()

func _change_state():
	sysmode_state.exit()
	sysmode_state = next_sysmode_state
	sysmode_state.enter()
	if sysmode_state == $testrout_states/auto:
		current_state_set = "auto"
		next_sysmode_state = $testrout_states/selective
	else:
		current_state_set = "selective"
		next_sysmode_state = $testrout_states/auto
	var status_screen = get_node("../..")
	status_screen._get_settings()

func _get_state():
	return current_state_set
