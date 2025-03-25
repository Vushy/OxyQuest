extends Node2D

@onready var timer = $Timer
@onready var timer_label = $TimerLabel  # Reference the label

var total_matches = 4  # Adjust this based on your game
var current_matches = 0
var time_left = 15  # Set the starting time in seconds

func _ready():
	timer.start()
	update_timer_label()  # Show initial time

func _process(_delta):
	time_left = int(timer.time_left)  # Update the time left
	update_timer_label()

func _on_timer_timeout():
	game_over(false)  # Player loses if time runs out

func increase_match_count():
	current_matches += 1
	if current_matches == total_matches:
		timer.stop()
		game_over(true)  # Player wins when all matched

func game_over(player_won: bool):
	timer.stop()  # Ensure the timer stops
	if player_won:
		timer_label.text = "You Won!"
	else:
		timer_label.text = "Time's Up!"
	
	print("Game Over!")  # Debugging (Check if this prints)


func update_timer_label():
	if time_left <= 10:
		timer_label.add_theme_color_override("font_color", Color.RED)
	timer_label.text = "Time: " + str(time_left)
