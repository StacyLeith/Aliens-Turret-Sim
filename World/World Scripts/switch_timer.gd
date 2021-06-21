extends Timer

onready var worldnode = get_parent()

func _ready():
	worldnode.connect("switching", self, "_waiting")  

func _waiting():
	self.start()
