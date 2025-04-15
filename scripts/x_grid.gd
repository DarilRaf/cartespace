extends HBoxContainer

var x = 0

func _on_coordinate_input_text_changed(new_text: String) -> void:
	var parts = new_text.strip_edges().split(" ")
	if parts.size() != 2:
		if parts.size() == 1:
			var x = int(parts[0])
		else:
			return  # Ignore invalid input

	x = int(parts[0])  # We're only highlighting X here
	highlight(x)

func highlight(number: int):
	for i in range(get_child_count()):
		var col_rect = get_child(i)
		if not col_rect is ColorRect:
			continue  # Just in case there's non-ColorRects

		if i == number:
			var color = col_rect.color
			color.a = 1.0  # full opacity
			col_rect.color = color
		else:
			var color = col_rect.color
			color.a = 0.2  # low alpha for non-highlighted
			col_rect.color = color


func _on_coordinate_input_text_submitted(new_text: String) -> void:
	highlight(0)
