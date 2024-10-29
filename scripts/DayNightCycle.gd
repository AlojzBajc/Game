extends CanvasModulate

const NIGHT_COLOR = Color("#ffffff")    #091d3a
const DAY_COLOR = Color("#ffffff")    
const TIME_SCALE = 0.05
var time = 0

# Referenca na sekundarno CanvasModulate vozlišče za ozadje.
@export var BackCanvasModulate: CanvasModulate

func _process(delta: float) -> void:
	self.time += delta * TIME_SCALE
	self.color = NIGHT_COLOR.lerp(DAY_COLOR, abs(sin(time)))
	
	# Sinhronizacija barve na sekundarnem CanvasModulate (za ozadje)
	if BackCanvasModulate:
		BackCanvasModulate.color = self.color
