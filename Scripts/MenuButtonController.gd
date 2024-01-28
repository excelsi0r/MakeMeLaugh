extends Button


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

@onready var audioS = get_node("../HoverSound") # or whatever you named the AudioStreamPlayer node

func _on_mouse_entered():
	audioS.play(0.0)
	pass # Replace with function body.
