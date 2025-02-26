extends Node2D


var interacting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if interacting == true:
		if Input.is_action_just_pressed("chat"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/script 1.dialogue"))
			global.portal_interaction = true
			return


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		interacting = true
		print(interacting)
