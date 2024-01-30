extends Node

@onready var timer : Timer = get_node("Timer")
@onready var cursor_on_timer : Timer = get_node("CursorOn")
@onready var cursor_off_timer : Timer = get_node("CursorOff")
@onready var labels : Array[Node] = get_node("./MarginContainer/VBoxContainer").get_children()
@onready var labels_text : Array[String] = []

@export var initialDelay : float = 5.0
@export var minTime : float = 0.05
@export var maxTime : float = 0.2
@export var timeBetweenParagraphs : float = 3.0
@export var cursorBlink : float = 0.75
@export var cursor : String = "█"
@export var negativeCursor  : String = " "

var currLabel : int = 0
var currCursorPos : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(len(labels)):
		labels_text.push_back("")
		labels_text[i] = labels[i].text
		labels[i].text = ""
	cursor_on()
	reset_timer(initialDelay)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"jump"):
		get_tree().change_scene_to_file("res://Levels/Level1/Level1.tscn")

func reveal_chars():

	# Verify I have yet to iterate labels
	cursor_on()
	key_sound()
	if currLabel < len(labels):
		labels[currLabel].text = labels[currLabel].text.insert(currCursorPos, labels_text[currLabel][currCursorPos])
		currCursorPos += 1
		if currCursorPos >= len(labels_text[currLabel]):
			currLabel += 1
			currCursorPos = 0
			reset_timer(timeBetweenParagraphs)
			$EnterTimer.start(cursorBlink)
		else:
			reset_timer(randf_range(minTime, maxTime))
		

func reset_timer(time: float):
	timer.start(time)


func cursor_on():

	var tmpLabel = currLabel
	var tmpCurrCursor = currCursorPos	
	if tmpLabel >= len(labels):
		tmpLabel -= 1
		tmpCurrCursor = len(labels_text[tmpLabel])
		
	labels[tmpLabel].text = labels[tmpLabel].text.substr(0, tmpCurrCursor) + cursor
	cursor_off_timer.start(cursorBlink)

func curor_off():
	var tmpLabel = currLabel
	var tmpCurrCursor = currCursorPos

	if tmpLabel >= len(labels):
		tmpLabel -= 1
		tmpCurrCursor = len(labels_text[tmpLabel])
	
	elif tmpCurrCursor == 0 and tmpLabel - 1 >= 0:
		labels[tmpLabel-1].text = labels[tmpLabel-1].text.substr(0, len(labels_text[tmpLabel-1])) + negativeCursor
		
	
	labels[tmpLabel].text = labels[tmpLabel].text.substr(0, tmpCurrCursor) + negativeCursor
	cursor_on_timer.start(cursorBlink)

func key_sound():
	$KeySound.pitch_scale = randf_range(0.9, 1.2)
	$KeySound.play()

func enter_new_line():
	$KeySound.pitch_scale = 0.5
	$KeySound.play()
