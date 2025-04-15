extends Node2D

@export var input_field: LineEdit
@export var earth: Area2D
@export var asteroid_scene: PackedScene
@export var spawn_interval := 3.0  # seconds between spawns
@onready var asteroid_counter: Label = $"../AsteroidCounter"

var total_hit = 0

const SAFE_X = [1, 2, 3, 4, 5, 6, 7, 8, 9, 22, 23, 24, 25, 26, 27, 28, 29, 30]
const SAFE_Y = [1, 2, 3, 4, 13, 14, 15, 16]

func _ready() -> void:
	start_spawning()


func start_spawning() -> void:
	spawn_loop()


func spawn_loop() -> void:
	# You can use async/yield loop or recursion
	await get_tree().create_timer(spawn_interval).timeout
	spawn_asteroid()
	spawn_loop()  # recursive loop


func spawn_asteroid() -> void:
	if not asteroid_scene:
		print("❌ No asteroid scene assigned")
		return

	var asteroid = asteroid_scene.instantiate()
	add_child(asteroid)

	asteroid.earth = earth

	var x = SAFE_X[randi() % SAFE_X.size()]
	var y = SAFE_Y[randi() % SAFE_Y.size()]
	asteroid.set_grid_position(x, y)
	
	asteroid_counter.update_count(get_child_count())


func _on_coordinate_input_text_submitted(text: String) -> void:
	var parts = text.strip_edges().split(" ")
	if parts.size() != 2:
		print("❌ Invalid input format. Use X,Y like '12 4'")
		input_field.text = ""
		return

	var x = int(parts[0])
	var y = int(parts[1])

	for asteroid in get_children():
		var grid_pos = asteroid.get_grid_position()
		if grid_pos[0] == x and grid_pos[1] == y:
			print("✅ Direct hit at ", x, ", ", y)
			asteroid.crashed = true  # or trigger explosion, destroy it, etc
			Global.add_hit()
			asteroid_counter.update_count(get_child_count() - 1)  # subtracting pre-queue_free
			asteroid.queue_free()

	# CLEAR FIELD
	input_field.text = ""


func _on_radar_area_entered(asteroid: Area2D) -> void:
	if asteroid.is_in_group("asteroid_tag"):
		if asteroid.visible == false:
			asteroid.set_visible(true)
		else:
			asteroid.move_toward_earth()
		print("DETECTED")


func _on_shoot_pressed() -> void:
	var text = input_field.text
	_on_coordinate_input_text_submitted(text)
