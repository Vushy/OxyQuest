extends Label

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP  # Ensure the label captures mouse events

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		set_drag_preview(self)  # Optional: Set a visual preview for the drag
		set_drag_data(text)  # Initiate the drag with the label's text
