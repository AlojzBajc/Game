extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	# Preverite, ali telo prihaja iz leve strani ali desne strani
	if body.is_in_group("enemies") or body.is_in_group("player"):
		print("Umru!")  # Uporabite za testiranje
		Engine.time_scale = 0.5

		# Dodajte samo-dodelitev in preverjanje
		if body.is_in_group("enemies"):
			body.take_damage()  # Kličemo metodo take_damage na nasprotniku
		elif body.is_in_group("player"):
			body.take_damage()  # Kličemo metodo take_damage na igralcu

		timer.start()
