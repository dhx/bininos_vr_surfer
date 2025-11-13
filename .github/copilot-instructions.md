# Copilot Instructions

## Project context
- Godot 4.3 VR surfing prototype targeting Meta Quest hardware.
- Primary language is GDScript; scenes live under `scenes/`, scripts under `scripts/`.
- Wave, surfer, and VR controller logic already exist — prefer extending them over rewriting.

## Development workflow
- Run quick syntax validation with `godot --headless --path . --check-only`.
- Use the new CI workflow (`.github/workflows/ci.yml`) as the source of truth for required checks.
- Keep scripts free of trailing spaces and prefer clear, descriptive method names.
- When adding new scripts, place them under `scripts/` and wire them through the relevant scene in `scenes/`.

## Testing guidance
- Add automated coverage by creating GDScript unit tests or scene-based assertions and invoke them via the Godot CLI (`godot --headless --path . --run-tests`).
- If integration tests rely on VR hardware, guard them so they can be skipped in headless CI.
- Favor deterministic simulations for wave and physics systems to keep tests stable.

## Release automation
- Tag releases with the `v*` pattern to trigger `.github/workflows/release.yml`.
- The release pipeline packages a `.pck` build and a source archive; extend it with platform exports (Android/Quest) when signing assets and SDK secrets are available.
- Keep `export_presets.cfg` in sync with the release workflow so export names match exactly.

## Pull request expectations
- Explain gameplay or physics changes clearly in PR descriptions; reviewers need to know how they impact VR comfort and performance.
- Mention any assets or binary dependencies introduced; store large binaries outside the repo when possible.
- Update documentation (`DEVELOPMENT.md`) whenever workflows, build commands, or VR controls change.
