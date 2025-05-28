extends Control

@onready var credit_screen: ColorRect = $CreditScreen
const LEVEL = preload("res://scenes/level.tscn")

func _on_play_pressed() -> void:
	if LEVEL:
		get_tree().change_scene_to_packed(LEVEL)
	else:
		print("❌ No level scene assigned.")


func _on_back_pressed() -> void:
	credit_screen.set_visible(false)


func _on_credit_pressed() -> void:
	credit_screen.set_visible(true)


func _on_exit_pressed() -> void:
	get_tree().quit()
