extends Control 
# Extends its base node

onready var sysmode_state = $sysmode_states/auto_remote 
# Sets the mode when the scene is loaded
onready var next_sysmode_state = $sysmode_states/man_override 
# Sets the next mode to select

var current_state_set = "auto_remote"
# Variable to send back when asked for set state

func _ready(): 
	# Function fires when the script has fully loaded
	$BTN_SYSTEM_MODE.connect("pressed", self, "_change_state") 
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
	if sysmode_state == $sysmode_states/auto_remote:
		current_state_set = "auto_remote"
		# Setting the current state setting for callback when asked
		next_sysmode_state = $sysmode_states/man_override
	elif sysmode_state == $sysmode_states/man_override:
		current_state_set = "man_override"
		next_sysmode_state = $sysmode_states/semi_auto
	else:
		current_state_set = "semi_auto"
		next_sysmode_state = $sysmode_states/auto_remote
		# Just an else/if to set the new next mode, to enable them to toggle through selections
	var status_screen = get_node("../..")
	status_screen._get_settings()
	# Sets a variable for the status_screen node so I can call it's function to check settings when they change
	
func _get_state():
	return current_state_set
