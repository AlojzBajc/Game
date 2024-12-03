extends Node2D

# Referenca na bullet (nastavi v inspectorju) - test
@export var bullet_scene: PackedScene

func _process(delta: float) -> void:
	
	look_at(get_global_mouse_position())
