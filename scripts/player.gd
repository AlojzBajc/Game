extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -500.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon = $Weapon
@onready var arms = $Arms
@onready var arms_sprite = $AnimatedSprite2D
var bullet = preload("res://scenes/bullet.tscn")
var direction = 0.0

func _ready():
	animated_sprite_2d.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta: float) -> void:
	# Dodaj gravitacijo
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Preveri, ali se strelja
	if Input.is_action_pressed("shoot"):
		var bullet_i = bullet.instantiate()
		bullet_i.transform = $Weapon.transform
		$bullets.add_child(bullet_i)

	# Preveri, ali se skače
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")
	elif is_on_floor():
		if direction != 0:
			animated_sprite_2d.flip_h = direction < 0
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")

	# Pridobi smer gibanja
	direction = Input.get_axis("move_left", "move_right")

	# Premik lika
	velocity.x = direction * SPEED
	move_and_slide()
	


	
	
