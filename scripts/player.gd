extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

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
	
func _process(_delta):
	update_arms_position()
	#update_sprite_flip()
	

func update_arms_position():
	var mouse_position = get_global_mouse_position()
	arms.look_at(mouse_position)
	
	# Omejitev rotacije za bolj naraven izgled
	var angle = arms.rotation_degrees
	if angle < -45:  # Omejitev na -45 stopinj
		angle = -45
	elif angle > 45:  # Omejitev na +45 stopinj
		arms.rotation_degrees = angle

	# Flip horizontalno glede na pozicijo miške glede na igralca
	if mouse_position.x < global_position.x:
		arms.flip_h = true
	else:
		arms.flip_h = false

#func update_sprite_flip():
	## Pridobi pozicijo miške in primerjaj z likom
	#var mouse_position = get_global_mouse_position()
	#var should_flip = mouse_position.x < global_position.x
#
	## Nastavi `flip_h` glede na položaj miške
	#animated_sprite_2d.flip_h = should_flip
#
	## Preverite nastavitev z izpisom
	#print("Mouse X:", mouse_position.x, " | Player X:", global_position.x)
	#print("flip_h set to:", animated_sprite_2d.flip_h)
#
#func update_arms_position():
	#
	#var mouse_position = get_global_mouse_position()
	#var mouse_dir = global_position.direction_to(mouse_position)
	##arms.flip_h = mouse_position.x < global_position.x
	#arms.rotation = mouse_dir.angle()
	#
	#if arms.rotation_degrees > 90 and arms.rotation_degrees > 270:
		#arms.rotation_degrees = clampf(arms.rotation_degrees, sign(mouse_dir.x *-1) - 20.0, sign(mouse_dir.x *-1) + 20.0)
		#
		#
	#else :
		#arms.rotation_degrees = clampf(arms.rotation_degrees, sign(mouse_dir.x) - 20.0, sign(mouse_dir.x) + 20.0)
#
	#print("degrees:", arms.rotation_degrees)		
