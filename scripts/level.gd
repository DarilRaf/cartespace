extends ColorRect

var main_menu_scene: PackedScene = preload("res://scenes/main_menu.tscn")

func _ready() -> void:
	Global.reset_hit()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_play_pressed() -> void:
	get_tree().reload_current_scene()
