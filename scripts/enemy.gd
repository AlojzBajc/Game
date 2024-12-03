extends CharacterBody2D

@export var SPEED: float = 50.0
@export var GRAVITY: float = 500.0
@export var JUMP_FORCE: float = -160.0 # Sila skoka

var DIRECTION: int = 1
@onready var GROUNDCHECK = $RayCast2D

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = JUMP_INTERVAL
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta: float) -> void:
	# Gravitacija
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Premikanje
	velocity.x = DIRECTION * SPEED
	move_and_slide()

	# Obrni smer, če naleti na zid ali pade z roba
	if is_on_wall() or not GROUNDCHECK.is_colliding():
		DIRECTION *= -1
		update_raycast_direction()

func update_raycast_direction():
	# Posodobi smer raycasta
	GROUNDCHECK.target_position = Vector2(DIRECTION * 20, GROUNDCHECK.target_position.y)
