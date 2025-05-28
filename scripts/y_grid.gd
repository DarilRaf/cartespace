extends VBoxContainer

@export var click: AudioStreamPlayer

var y = 0

func _on_coordinate_input_text_changed(new_text: String) -> void:
	var parts = new_text.strip_edges().split(" ")
	if parts.size() != 2:
		y = 0
	else:
		y = int(parts[1])
	if click:
		click.play()
	highlight(y)

func highlight(number: int):
	for i in range(get_child_count()):
		var col_rect = get_child(i)
		if not col_rect is ColorRect:
			continue  # Safety check

		if i == number:
			var color = col_rect.color
			color.a = 1.0  # fully visible
			col_rect.color = color
		else:
			var color = col_rect.color
			color.a = 0.2  # dimmed
			col_rect.color = color


func _on_coordinate_input_text_submitted(new_text: String) -> void:
	highlight(0)
