extends Node2D

var health = 10
const SPEED = 40
var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	elif ray_cast_left.is_colliding():  
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta
	
func take_damage():
	health -= 10
	if health <= 0:
		queue_free()  # Odstrani nasprotnika, ko je ubit zanima me  kaj moram naredit da bo enemy dobil collision od  attack animacije in nato predvajal animacijo hurt? 
