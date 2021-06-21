extends TextureButton

onready var worldnode = get_node("../../../..")

func _pressed():
	worldnode.play_beep()
