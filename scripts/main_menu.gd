extends Control

@export var level: PackedScene
@onready var credit_screen: ColorRect = $CreditScreen

func _on_play_pressed() -> void:
	if level:
		get_tree().change_scene_to_packed(level)
	else:
		print("❌ No level scene assigned.")


func _on_back_pressed() -> void:
	credit_screen.set_visible(false)


func _on_credit_pressed() -> void:
	credit_screen.set_visible(true)


func _on_exit_pressed() -> void:
	get_tree().quit()
