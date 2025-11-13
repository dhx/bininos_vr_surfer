extends Node3D

# VR Controller Manager
# Handles VR controller input and integrates with surfer movement

var left_controller: XRController3D
var right_controller: XRController3D
var xr_camera: XRCamera3D
var surfer: CharacterBody3D

var camera_follow_enabled: bool = true

func _ready():
	# Get VR components
	left_controller = get_node("XROrigin3D/LeftController")
	right_controller = get_node("XROrigin3D/RightController")
	xr_camera = get_node("XROrigin3D/XRCamera3D")
	surfer = get_node("Surfer/SurferBody")
	
	# Connect controller signals
	if left_controller:
		left_controller.button_pressed.connect(_on_left_button_pressed)
		left_controller.button_released.connect(_on_left_button_released)
		
	if right_controller:
		right_controller.button_pressed.connect(_on_right_button_pressed)
		right_controller.button_released.connect(_on_right_button_released)
	
	print("VR Controllers initialized")

func _process(_delta):
	handle_controller_input()
	update_camera_follow()

func handle_controller_input():
	if not surfer or not left_controller or not right_controller:
		return
	
	# Get controller input vectors
	var left_input = Vector2.ZERO
	var right_input = Vector2.ZERO
	
	# Get thumbstick/trackpad input
	if left_controller.get_float("primary"):
		left_input.x = left_controller.get_vector2("primary").x
		left_input.y = left_controller.get_vector2("primary").y
	
	if right_controller.get_float("primary"):
		right_input.x = right_controller.get_vector2("primary").x  
		right_input.y = right_controller.get_vector2("primary").y
	
	# Send input to surfer controller
	if surfer.has_method("handle_controller_input"):
		surfer.handle_controller_input(left_input, right_input)

func update_camera_follow():
	if not camera_follow_enabled or not surfer or not xr_camera:
		return
	
	# Follow surfer with VR camera
	var target_position = surfer.global_position + Vector3(0, 1.8, 0)
	var xr_origin = get_node("XROrigin3D")
	
	# Smooth camera following
	xr_origin.global_position = xr_origin.global_position.lerp(
		target_position, 
		get_process_delta_time() * 3.0
	)

func _on_left_button_pressed(button: String):
	match button:
		"trigger_click":
			# Left trigger - maybe for speed boost
			if surfer and surfer.has_method("activate_speed_boost"):
				surfer.activate_speed_boost()
		"grip_click":
			# Left grip - toggle camera follow
			camera_follow_enabled = !camera_follow_enabled
			print("Camera follow: ", camera_follow_enabled)

func _on_left_button_released(button: String):
	match button:
		"trigger_click":
			if surfer and surfer.has_method("deactivate_speed_boost"):
				surfer.deactivate_speed_boost()

func _on_right_button_pressed(button: String):
	match button:
		"trigger_click":
			# Right trigger - maybe for balance assistance
			if surfer and surfer.has_method("activate_balance_assist"):
				surfer.activate_balance_assist()
		"grip_click":
			# Right grip - reset surfer position
			if surfer and surfer.has_method("start_surfing"):
				surfer.start_surfing()

func _on_right_button_released(button: String):
	match button:
		"trigger_click":
			if surfer and surfer.has_method("deactivate_balance_assist"):
				surfer.deactivate_balance_assist()

func get_controller_orientation(controller: XRController3D) -> Vector3:
	# Get controller rotation for balance input
	if controller:
		return controller.transform.basis.get_euler()
	return Vector3.ZERO

func haptic_feedback(controller: XRController3D, strength: float, duration: float):
	# Provide haptic feedback for immersion
	if controller:
		# Note: Haptic feedback implementation depends on the XR interface
		controller.trigger_haptic_pulse("haptic", 0, strength, duration, 0)