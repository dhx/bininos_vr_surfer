extends Node3D

# Beach Environment System
# Creates the tropical beach setting with sand, palm trees, and ambient effects

var beach_materials = {}

func _ready():
	create_beach_terrain()
	create_skybox()
	add_palm_trees()
	print("Beach environment created")

func create_beach_terrain():
	# Find the beach terrain nodes from the main scene
	var beach_terrain = get_node("../Beach/BeachTerrain")
	var beach_mesh_instance = get_node("../Beach/BeachTerrain/BeachMesh")
	var beach_collision = get_node("../Beach/BeachTerrain/BeachCollision")
	
	# Create beach plane mesh
	var beach_plane = PlaneMesh.new()
	beach_plane.size = Vector2(100, 100)
	beach_plane.subdivide_width = 10
	beach_plane.subdivide_depth = 10
	
	beach_mesh_instance.mesh = beach_plane
	
	# Create beach material (sand)
	var sand_material = StandardMaterial3D.new()
	sand_material.albedo_color = Color(0.96, 0.87, 0.70, 1)  # Sand color
	sand_material.roughness = 0.9
	sand_material.metallic = 0.0
	beach_mesh_instance.material_override = sand_material
	
	# Add collision shape
	var shape = BoxShape3D.new()
	shape.size = Vector3(100, 2, 100)
	beach_collision.shape = shape

func create_skybox():
	# Create a simple gradient sky
	var sky = Sky.new()
	var sky_material = ProceduralSkyMaterial.new()
	sky_material.sky_horizon_color = Color(0.64, 0.65, 0.67)
	sky_material.sky_top_color = Color(0.35, 0.46, 0.71)
	sky_material.ground_bottom_color = Color(0.12, 0.12, 0.13)
	sky_material.ground_horizon_color = Color(0.37, 0.33, 0.31)
	sky.sky_material = sky_material
	
	# Apply to world environment
	var world_env = get_node("../Environment/WorldEnvironment")
	world_env.environment.sky = sky
	world_env.environment.background_mode = Environment.BG_SKY

func add_palm_trees():
	# Create simple palm tree representations using basic shapes
	for i in range(5):
		create_simple_palm_tree(Vector3(
			randf_range(-40, -20),  # Position on beach side
			-1,
			randf_range(-40, 40)
		))

func create_simple_palm_tree(pos: Vector3):
	var tree = Node3D.new()
	tree.position = pos
	add_child(tree)
	
	# Trunk
	var trunk = MeshInstance3D.new()
	var trunk_mesh = CylinderMesh.new()
	trunk_mesh.height = 8
	trunk_mesh.top_radius = 0.3
	trunk_mesh.bottom_radius = 0.4
	trunk.mesh = trunk_mesh
	trunk.position = Vector3(0, 4, 0)
	
	# Trunk material (brown)
	var trunk_material = StandardMaterial3D.new()
	trunk_material.albedo_color = Color(0.4, 0.25, 0.1)
	trunk.material_override = trunk_material
	
	tree.add_child(trunk)
	
	# Palm fronds (simplified as green spheres)
	for i in range(6):
		var frond = MeshInstance3D.new()
		var frond_mesh = SphereMesh.new()
		frond_mesh.radius = 1.5
		frond_mesh.height = 3
		frond.mesh = frond_mesh
		
		var angle = (i * PI * 2) / 6
		frond.position = Vector3(
			cos(angle) * 2, 
			8, 
			sin(angle) * 2
		)
		frond.rotation = Vector3(randf_range(-0.3, 0.3), angle, randf_range(-0.2, 0.2))
		
		# Frond material (green)
		var frond_material = StandardMaterial3D.new()
		frond_material.albedo_color = Color(0.2, 0.6, 0.2)
		frond.material_override = frond_material
		
		tree.add_child(frond)