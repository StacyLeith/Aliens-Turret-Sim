extends AnimatedSprite
# Extends from the node, yada yada

func _ready():
	# Standard ready function
	var parent = self.get_parent()
	# Sets the variable parent to the node that this script is the child of
	parent.connect("enabled", self, "_enable")
	parent.connect("disabled", self, "_disable")
	# These connect the parent nodes enable and disable signals to this node
	
func _enable():
	self.set("frame", 1)
	
func _disable():
	self.set("frame", 0)
# This changes the frame when the parent nodes signal says too
