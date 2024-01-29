extends AudioStreamPlayer

#var minVal = 10.0
#var maxVal = 20.0

var minVal = 300.0
var maxVal = 600.0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play_sound():
	reset_timer()
	play()
	
func reset_timer():
	$Timer.start(randf_range(minVal, maxVal))
	print($Timer.wait_time)

func _on_timer_timeout():
	play_sound()
