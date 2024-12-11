extends Node2D
@onready var timer = $Timer

var transition = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$transition.play("transition")
	
	
func transitionTrachea():
	if transition:
		timer.start(2)
		if transition == true:
		
			get_tree().change_scene_to_file("res://scene/Trachea_Paths.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transitionTrachea()


func _on_area_2d_body_entered(body) -> void:
	if body.has_method('player'):
		$AnimatedSprite2D.play('portal')
		transition = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		$AnimatedSprite2D.stop()


func _on_transition_area_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		$transition.play('transition_out')
