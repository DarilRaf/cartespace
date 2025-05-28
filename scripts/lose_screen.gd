extends ColorRect

@onready var score: Label = $VBoxContainer/Score

@onready var LEVEL = preload("res://scenes/level.tscn")
@onready var MAIN_MENU = preload("res://scenes/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = "Score: %d" % Global.total_hit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/level.tscn"))


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))
