extends AnimatedSprite

func _ready():
	var parent = self.get_parent()
	parent.connect("enabled", self, "_enable")
	parent.connect("disabled", self, "_disable")
	
func _enable():
	self.set("frame", 1)
	
func _disable():
	self.set("frame", 0)
