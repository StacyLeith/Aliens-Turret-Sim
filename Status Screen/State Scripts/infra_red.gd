extends "res://Status Screen/State Scripts/states.gd"
# Lets this script inherit the functions in states.gd. Keeps everything the same, with correct arguements etc

signal enabled
signal disabled
# Custom signals to tell the sprites what to do

func _update():
	pass
# The update function that the main state machine defers to for the current state

func enter():
	# The enter function, everything below will fire when the state is changed to this one
	emit_signal("enabled")
	# Emits the enabled signal to change the frames on the sprites

func exit():
	# The exit function that fires when the mode is changed away from this mode
	emit_signal("disabled")
	# Emits the disabled signal to change the frames on the sprites
