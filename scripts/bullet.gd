extends Area2D

# Konstantna hitrost naboja
const BULLET_SPEED = 500.0  # Hitrost naboja

func _ready() -> void:
	pass
   
func _physics_process(delta: float) -> void:
	# Premik naboja
	global_position += transform.x * BULLET_SPEED * delta

# Ta funkcija se izvede, ko se naboj dotakne drugega telesa
func _on_body_entered(body):
	# Preveri, ali se naboj dotakne TileMap
	if body.is_in_group("tilemap"):  # Predpostavlja se, da je TileMap v skupini "tilemap"
		queue_free()  # Ustavi naboj, ko se dotakne TileMap

# Ne pozabite dodati signala za povezovanje funkcije _on_body_entered
