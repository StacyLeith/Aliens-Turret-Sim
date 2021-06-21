extends Control 
# Extends its base node


onready var sysmode_state = $tarsel_states/multi_spec
# Sets the mode when the scene is loaded
onready var next_sysmode_state = $tarsel_states/infra_red
# Sets the next mode to select

var current_state_set = "multi_spec"

func _ready(): 
	# Function fires when the script has fully loaded
	$BTN_TARGET_SELECT.connect("pressed", self, "_change_state") 
	# Connects the button nodes signal pressed to this node and tells it to fire the function _change_state
	sysmode_state.enter()
	# Fires the state enter function on the current states node
	
func _process(delta):
	# Process that gets called every frame
	sysmode_state._update()
	# defers the update to the current state nodes update

func _change_state():
	# The function fired when the state needs to change
	sysmode_state.exit()
	# Exits the current state using the exit function I have written on the node
	sysmode_state = next_sysmode_state
	# Changes the current state var to the set next state
	sysmode_state.enter()
	# Enters the new state set above, with the enter function on the node
	if sysmode_state == $tarsel_states/multi_spec:
		current_state_set = "multi_spec"
		next_sysmode_state = $tarsel_states/infra_red
	elif sysmode_state == $tarsel_states/infra_red:
		current_state_set = "infra_red"
		next_sysmode_state = $tarsel_states/uv
	else:
		current_state_set = "uv"
		next_sysmode_state = $tarsel_states/multi_spec
	# Just an else/if to set the new next mode, to enable them to toggle through selections
	var status_screen = get_node("../..")
	status_screen._get_settings()

func _get_state():
	return current_state_set
