extends Node3D

# VR Surfer Main Scene
# This script manages the overall game flow and VR initialization

var xr_interface: XRInterface
var vr_controller_manager: Node3D

func _ready():
	# Initialize VR
	init_vr()
	
	# Setup VR controller manager
	vr_controller_manager = load("res://scripts/VRControllerManager.gd").new()
	add_child(vr_controller_manager)
	
	# Setup initial state
	print("VR Surfer initialized")

func init_vr():
	# Get the OpenXR interface
	xr_interface = XRServer.find_interface("OpenXR")
	
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")
		
		# Enable VR mode
		get_viewport().use_xr = true
	else:
		print("OpenXR not available, running in pancake mode")