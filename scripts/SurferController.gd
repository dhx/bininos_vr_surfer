extends CharacterBody3D

# Surfer Controller
# Handles surfboard physics and player movement on waves

@export var board_speed: float = 5.0
@export var balance_sensitivity: float = 2.0
@export var gravity_strength: float = 9.8

var wave_system: Node3D
var board_mesh: MeshInstance3D
var is_surfing: bool = false
var board_tilt: Vector3 = Vector3.ZERO
var current_wave_height: float = 0.0

signal balance_changed(new_balance: float)

func _ready():
	# Find wave system
	wave_system = get_node("../../WaveSystem")
	
	# Create surfboard visual
	create_surfboard()
	
	# Start surfing
	start_surfing()
	
	print("Surfer initialized")

func create_surfboard():
	# Create simple surfboard mesh
	board_mesh = MeshInstance3D.new()
	var board_shape = BoxMesh.new()
	board_shape.size = Vector3(0.3, 0.1, 2.0)  # Wide, thin, long board
	board_mesh.mesh = board_shape
	
	# Board material (white/blue surfboard)
	var board_material = StandardMaterial3D.new()
	board_material.albedo_color = Color(1, 1, 1, 1)
	board_material.metallic = 0.1
	board_material.roughness = 0.3
	board_mesh.material_override = board_material
	
	add_child(board_mesh)
	
	# Add collision shape for the character body
	var collision_shape = CollisionShape3D.new()
	var shape = BoxShape3D.new()
	shape.size = Vector3(0.5, 0.5, 2.2)
	collision_shape.shape = shape
	add_child(collision_shape)

func start_surfing():
	is_surfing = true
	position = Vector3(0, 1, -5)  # Start position on the wave

func _physics_process(delta):
	if not is_surfing or not wave_system:
		return
	
	# Get wave height and normal at current position
	current_wave_height = wave_system.get_wave_height_at_position(global_position)
	var wave_normal = wave_system.get_wave_normal_at_position(global_position)
	
	# Apply wave following (stay on surface)
	var target_y = current_wave_height + 0.5  # Offset to stay above water
	position.y = lerp(position.y, target_y, delta * 5.0)
	
	# Apply board tilting based on wave slope
	var target_rotation = Vector3(
		-wave_normal.z * balance_sensitivity,  # Pitch
		0,  # Yaw (controlled by player)
		wave_normal.x * balance_sensitivity   # Roll
	)
	
	rotation = rotation.lerp(target_rotation, delta * 3.0)
	
	# Basic forward movement (surfing down the wave)
	var forward_direction = -transform.basis.z
	velocity = forward_direction * board_speed
	
	# Add gravity effect
	if not is_on_floor():
		velocity.y -= gravity_strength * delta
	
	# Apply movement
	move_and_slide()

func handle_controller_input(left_input: Vector2, right_input: Vector2):
	# Handle VR controller input for steering
	if not is_surfing:
		return
	
	# Use controller input for steering (yaw rotation)
	var steering_input = left_input.x + right_input.x
	rotation.y += steering_input * balance_sensitivity * get_process_delta_time()
	
	# Use controller input for speed control
	var speed_input = -left_input.y - right_input.y
	board_speed = clamp(board_speed + speed_input * 2.0 * get_process_delta_time(), 2.0, 10.0)

func get_current_balance() -> float:
	# Return balance factor (0-1, where 1 is perfect balance)
	var tilt_magnitude = rotation.length()
	return clamp(1.0 - (tilt_magnitude / (PI * 0.25)), 0.0, 1.0)

func _on_wave_collision():
	# Handle collision with wave (could trigger wipeout)
	if get_current_balance() < 0.3:
		trigger_wipeout()

func trigger_wipeout():
	# Simple wipeout - reset position
	is_surfing = false
	position = Vector3(0, 5, -10)
	rotation = Vector3.ZERO
	# Re-enable surfing after delay
	await get_tree().create_timer(2.0).timeout
	start_surfing()