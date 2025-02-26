extends TextureRect

var original_texture: Texture2D  # Store original texture during drag

func _get_drag_data(at_position):
	original_texture = texture  # Save original before clearing
	texture = null  # Clear immediately for visual feedback
	
	# Create preview (keep your existing preview code)
	var preview_texture = TextureRect.new()
	preview_texture.texture = original_texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	
	return {"texture": original_texture, "source": self}

func _can_drop_data(_pos, data):
	return data is Dictionary and data.has("texture")

func _drop_data(_pos, data):
	# Handle successful drop on target
	texture = data["texture"]
	# Optional: Clear source texture if needed
	data["source"].texture = null

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		# If texture is still null after dragging, restore original
		if texture == null && original_texture != null:
			texture = original_texture
