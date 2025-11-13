# Game Project Prompt: VR Surfing Experience on Meta Quest with Godot

## Project Overview:

Create an immersive VR surfing game using Godot Engine targeting the Meta Quest platform. The core gameplay places the player in the first-person role of a surfer riding dynamic, breaking ocean waves on a beautiful tropical beach. The environment is rich and visually appealing, with realistic water physics, beach scenery, and multiple surfboards available for players to choose from before entering the water.
Key Features and Requirements:
1. Dynamic Ocean Waves with Breaking Effect

    Implement a wave simulation system (e.g., spring-based or FFT-based mesh deformation) that realistically simulates moving ocean waves.

    Waves must break near the shore with steep crests and white foam/spray particle effects.

    Wave motion should affect player movement and interaction naturally, with smooth physics-driven bobbing and tilting.

2. Surfer First-Person VR Viewpoint

    Attach the VR camera rig to a dynamically updated position on the wave mesh, simulating the position on a surfboard.

    Simulate the natural movement of surfing by tilting and bobbing the camera based on wave slope and height changes.

    Include player controls for balancing on the wave, adjusting speed, and maneuvering left or right.

3. Beautiful Beach Environment

    Design a lush, tropical beach setting with sand, palm trees, rocks, and ambient sounds (waves splashing, seagulls).

    Include a skybox or panoramic sky environment for realistic lighting and immersion.

4. Surfboard Selection System

    Create a collection menu or scene where players can browse and select from various surfboards, each with distinct attributes (speed, stability, turning).

    Surfboards should be visually detailed and compatible with the player's VR model.

    Upon selection, the player is transitioned to the surfing scene equipped with the chosen surfboard.

5. Meta Quest VR Compatibility

    Use Godot OpenXR or Oculus Mobile plugins to ensure smooth deployment and input handling on Meta Quest.

    Optimize for performance with techniques such as fixed foveated rendering and reduced shader complexity.

    Integrate VR interactions with Meta Quest controllers or hand tracking for grabbing, balancing, and interacting with surfboards.

6. Optional Enhancements

    Add environmental effects such as wind, foam particles, and splashes triggered by wave break and player movement.

    Implement a simple progression system with challenges or timed surfing courses.

    Include an ambient soundtrack or relaxing beach music.

Development Milestones:

    Prototype dynamic wave system with break near shore.

    Set up basic VR camera rig with surfboard attachment and motion simulation.

    Build beach environment scene with foliage and ambient effects.

    Develop surfboard selection UI/UX compatible with VR.

    Implement player controls for surfing mechanics.

    Test and optimize build for Meta Quest deployment.

    Add polish elements like particle effects, sound, and UI enhancements.

Deliverables:

    Fully functional Godot project folder with scenes, scripts, assets, and VR configurations.

    Clear documentation on setup and profile for Meta Quest export.

    Example scripts demonstrating wave simulation, VR camera control for surfing, and surfboard selection logic.

This prompt frames a comprehensive VR surfing game development task in Godot, focusing on realism, immersion, and Meta Quest compatibility with actionable milestones and feature lists. It aligns with the concept of moving breaking waves and a surfer viewpoint from previous discussion, adding the beach environment and surfboard collection to create a full game experience.