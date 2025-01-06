extends CharacterBody2D


var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var interacting = false
@onready var anim: AnimatedSprite2D = $anim

var player
var player_interact_zone = false



func _ready():
	anim.play("interactable")



	
func _process(delta):
	
	
	if player_interact_zone == true:
		if Input.is_action_just_pressed("chat"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "video_lesson")
			is_roaming = false
			interacting = true
			return
			


func lesson_npc():
	if global.dialogueFinished == true:
		is_roaming = true
		interacting = false
		return

func _on_interact_zone_body_entered(body):
	if body.has_method("player"):
		player = body
		player_interact_zone = true
		print("chatting with npc")


func _on_interact_zone_body_exited(body):
	if body.has_method("player"):
		player_interact_zone = false
