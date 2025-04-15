extends Area2D

@onready var radar_animation: AnimationPlayer = $RadarAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_scan_pressed() -> void:
	self.set_visible(true)
	radar_animation.play("radar")
	await radar_animation.animation_finished
	self.set_visible(false)
