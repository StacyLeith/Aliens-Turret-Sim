extends Node

var target_scene = load("res://Gameplay Scripts/target_spawner.tscn")

func spawn_target():
	var enemy = target_scene.instance()
	add_child(enemy)
