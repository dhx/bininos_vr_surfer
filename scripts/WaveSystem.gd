extends Node3D

# Wave System for VR Surfing
# Creates dynamic ocean waves using mesh deformation

@export var wave_strength: float = 1.0
@export var wave_speed: float = 2.0
@export var wave_frequency: float = 1.5
@export var mesh_resolution: int = 64

var ocean_mesh: MeshInstance3D
var original_vertices: PackedVector3Array
var plane_mesh: PlaneMesh
var time: float = 0.0

func _ready():
	create_ocean_mesh()
	
func create_ocean_mesh():
	# Create the ocean plane
	plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(100, 100)
	plane_mesh.subdivide_width = mesh_resolution
	plane_mesh.subdivide_depth = mesh_resolution
	
	# Create MeshInstance3D
	ocean_mesh = MeshInstance3D.new()
	ocean_mesh.mesh = plane_mesh
	ocean_mesh.position = Vector3(0, 0, 0)
	add_child(ocean_mesh)
	
	# Create simple water material
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.1, 0.3, 0.8, 0.7)
	material.metallic = 0.0
	material.roughness = 0.1
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.flags_unshaded = false
	ocean_mesh.material_override = material
	
	# Store original vertices
	var mesh_data_tool = MeshDataTool.new()
	mesh_data_tool.create_from_surface(plane_mesh, 0)
	
	original_vertices.clear()
	for i in range(mesh_data_tool.get_vertex_count()):
		original_vertices.append(mesh_data_tool.get_vertex(i))
	
	print("Ocean mesh created with ", original_vertices.size(), " vertices")

func _process(delta):
	time += delta
	update_waves()

func update_waves():
	if not ocean_mesh or original_vertices.is_empty():
		return
	
	# Create new mesh with deformed vertices
	var mesh_data_tool = MeshDataTool.new()
	mesh_data_tool.create_from_surface(plane_mesh, 0)
	
	# Apply wave deformation
	for i in range(mesh_data_tool.get_vertex_count()):
		var vertex = original_vertices[i]
		var wave_height = calculate_wave_height(vertex, time)
		vertex.y += wave_height
		mesh_data_tool.set_vertex(i, vertex)
	
	# Create new mesh
	var new_mesh = ArrayMesh.new()
	mesh_data_tool.commit_to_surface(new_mesh)
	ocean_mesh.mesh = new_mesh

func calculate_wave_height(vertex: Vector3, t: float) -> float:
	# Simple sine wave combination for realistic water movement
	var wave1 = sin(vertex.x * 0.1 + t * wave_speed) * wave_strength
	var wave2 = sin(vertex.z * 0.15 + t * wave_speed * 0.7) * wave_strength * 0.7
	var wave3 = sin((vertex.x + vertex.z) * 0.05 + t * wave_speed * 1.3) * wave_strength * 0.5
	
	return wave1 + wave2 + wave3

func get_wave_height_at_position(pos: Vector3) -> float:
	# Get wave height at specific world position
	return calculate_wave_height(pos, time)

func get_wave_normal_at_position(pos: Vector3) -> Vector3:
	# Calculate normal vector at position for realistic surfboard tilting
	var delta = 0.1
	var height_center = get_wave_height_at_position(pos)
	var height_x = get_wave_height_at_position(pos + Vector3(delta, 0, 0))
	var height_z = get_wave_height_at_position(pos + Vector3(0, 0, delta))
	
	var normal = Vector3(height_center - height_x, delta, height_center - height_z).normalized()
	return normal