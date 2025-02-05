extends CharacterBody2D

@export var maxHealth = 3
@onready var Playerhealth: int = maxHealth
const SPEED = 80
signal healthChanged

var current_dir = "none"
var NPC_IN_RANGE = false
var lesson_npc = false
var is_moving = false

func _ready():
	$AnimatedSprite2D.play("front_idle")


func _physics_process(delta):
	if NPC_IN_RANGE:
		if Input.is_action_just_pressed("chat"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "start")
			return

	player_movement(delta)
	current_cam()


# Player movement
func player_movement(delta):
	is_moving = false  # Reset movement flag before processing input
	if Input.get_action_strength("right") > 0:
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
		is_moving = true
	elif Input.get_action_strength("left") > 0:
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
		is_moving = true
	elif Input.get_action_strength("up") > 0:
		current_dir = "up"
		play_anim(1)
		velocity.y = -SPEED
		velocity.x = 0
		is_moving = true
	elif Input.get_action_strength("down") > 0:
		current_dir = "down"
		play_anim(1)
		velocity.y = SPEED
		velocity.x = 0
		is_moving = true
	else:
		play_anim(0)
		velocity = Vector2.ZERO

	# Handle footstep sound based on movement state
	handle_footstep_sound(is_moving)

	# Move the player
	move_and_slide()


# Handle footstep sounds
func handle_footstep_sound(is_moving: bool) -> void:
	if is_moving:
		if not $AudioStreamPlayer2D.is_playing():  # Play only if not already playing
			$AudioStreamPlayer2D.play()
	else:
		if $AudioStreamPlayer2D.is_playing():  # Stop only if currently playing
			$AudioStreamPlayer2D.stop()


# Movement animation
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D

	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	elif dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	elif dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
	elif movement == 0:
		anim.play("back_idle")


func _on_area_2d_body_entered(body):
	if body.has_method("NPC"):
		NPC_IN_RANGE = true
		print("inside")
	elif body.name == "lesson_npc":
		lesson_npc = true
		global.set_player_position(global_position)
		print("inside")


func _on_area_2d_body_exited(body):
	if body.has_method("NPC"):
		NPC_IN_RANGE = false


func current_cam():
	if global.current_scene == "world":
		$worldcam.enabled = true
		$nworldcam.enabled = false
	elif global.current_scene == "nworld":
		$worldcam.enabled = false
		$nworldcam.enabled = true
