extends "res://Status Screen/State Scripts/states.gd"

signal enabled
signal disabled

func _update():
	pass

func enter():
	emit_signal("enabled")

func exit():
	emit_signal("disabled")
