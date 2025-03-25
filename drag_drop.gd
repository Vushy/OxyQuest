extends TextureRect

@export var is_target: bool = false  # Distinguish between choices and target boxes
@export var match_id: String = ""  # Unique ID to match choices with the correct target

var original_texture: Texture2D  # Store original texture during drag

func _get_drag_data(at_position):
	if is_target:
		return  # Targets shouldn't be draggable
	
	original_texture = texture  # Save original before clearing
	texture = null  # Clear immediately for visual feedback
	
	# Create a preview of the dragged item
	var preview_texture = TextureRect.new()
	preview_texture.texture = original_texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	
	return {"texture": original_texture, "source": self, "match_id": match_id}

func _can_drop_data(_pos, data):
	# Allow dropping only if this is a target and the match_id matches
	return is_target and data is Dictionary and data.has("texture") and data.get("match_id") == match_id

func _drop_data(_pos, data):
	if data is Dictionary and data.has("texture"):
		if texture == null:  # Ensure it's an empty slot
			texture = data["texture"]
			data["source"].texture = null  # Clear the dragged texture
			
			# Notify the main scene that a match was made
			get_tree().get_root().get_node("Node2D").increase_match_count()


func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		# If texture is still null after dragging, restore original
		if texture == null && original_texture != null:
			texture = original_texture
