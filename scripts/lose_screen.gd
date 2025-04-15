extends ColorRect

@onready var score: Label = $VBoxContainer/Score
@export var level: PackedScene
@export var main_menu: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = "Score: %d" % Global.total_hit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
