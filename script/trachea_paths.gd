extends Node2D

@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("transition_in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_transition_area_1_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		call_deferred("change_scene", "res://scene/Trachea_Extend.tscn")


func _on_transition_area_2_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		call_deferred("change_scene", "res://scene/Trachea_Extend.tscn")
		
func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
