extends Area2D

@export var earth: Area2D
var crashed: bool = false
var moved: bool = false
var lose_screen: PackedScene = preload("res://scenes/lose_screen.tscn")

const TILE_SIZE := 37
const DIRECTIONS := {
	"right": Vector2(1, 0),
	"down": Vector2(0, 1),
	"left": Vector2(-1, 0),
	"up": Vector2(0, -1),
	"up_right": Vector2(1, -1),
	"up_left": Vector2(-1, -1),
	"down_right": Vector2(1, 1),
	"down_left": Vector2(-1, 1),
}

func _ready() -> void:
	var rand_x = get_safe_random(1, 30, 10, 21)
	var rand_y = get_safe_random(1, 16, 5, 12)

	set_grid_position(rand_x, rand_y)


func get_safe_random(min_val: int, max_val: int, exclude_start: int, exclude_end: int) -> int:
	var valid_values := []
	for i in range(min_val, max_val + 1):
		if i < exclude_start or i > exclude_end:
			valid_values.append(i)

	return valid_values[randi() % valid_values.size()]


func set_grid_position(x: int, y: int) -> void:
	global_position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
	
func grid_move(direction: String) -> void:
	if direction in DIRECTIONS:
		global_position += DIRECTIONS[direction] * TILE_SIZE
	else:
		print("Invalid direction: ", direction)
	
func get_grid_position() -> Array:
	var grid_x = int(round(global_position.x / TILE_SIZE))
	var grid_y = int(round(global_position.y / TILE_SIZE))
	return [grid_x, grid_y]


func move_toward_earth() -> void:
	if !moved:
		moved = true
		var diff = earth.global_position - global_position
		var dir := ""

		# Diagonal movement first
		if abs(diff.x) > TILE_SIZE and abs(diff.y) > TILE_SIZE:
			if diff.x > 0 and diff.y > 0:
				dir = "down_right"
			elif diff.x < 0 and diff.y > 0:
				dir = "down_left"
			elif diff.x > 0 and diff.y < 0:
				dir = "up_right"
			elif diff.x < 0 and diff.y < 0:
				dir = "up_left"
		else:	
			if abs(diff.x) > abs(diff.y):
				if diff.x > 0:
					dir = "right"
				else:
					dir = "left"
			elif abs(diff.y) > 0:
				if diff.y > 0:
					dir = "down"
				else:
					dir = "up"

		if dir != "":
			grid_move(dir)
			
		await get_tree().create_timer(1.0).timeout
		moved = false
		
		# Check if we hit Earth
		if global_position.distance_to(earth.global_position) < TILE_SIZE:
			crashed = true
			print("🌍 Impact! Asteroid hit Earth.")
			get_tree().change_scene_to_packed(lose_screen)
		
