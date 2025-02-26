extends Node2D
@onready var timer = $Timer
@onready var dir_buttons = $CanvasLayer2/Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$transition.play("transition")


	

		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	dir_buttons.visible = not global.portal_interaction

		

func _on_area_2d_body_entered(body) -> void:
	if body.has_method('player'):
		$AnimatedSprite2D.play('portal')
		$transition.play('transition_out')
		
		
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		$AnimatedSprite2D.stop()


func _on_transition_area_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scene/Trachea_Paths.tscn")
	
