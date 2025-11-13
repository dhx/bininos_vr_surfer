# VR Surfer - Minimal Viable Prototype

Ein minimaler funktionsfähiger Prototyp eines VR-Surfing-Spiels für Meta Quest, entwickelt mit Godot Engine.

## Funktionen

- ✅ **Dynamische Wellen-Simulation**: Mesh-Deformation mit Sinus-Wellen für realistische Wasserbewegung
- ✅ **VR-Setup**: OpenXR-Integration für Meta Quest Kompatibilität  
- ✅ **Strand-Environment**: Tropischer Strand mit Sand, Palmen und Himmel
- ✅ **Surfboard-Physik**: Grundlegende Surfboard-Bewegung die den Wellen folgt
- ✅ **VR-Steuerung**: Controller-Input für Lenkung und Balance
- ✅ **Kamera-Follow**: VR-Kamera folgt dem Surfer auf den Wellen

## Projekt-Struktur

```
bininos_vr_surfer/
├── project.godot           # Hauptprojektdatei
├── scenes/
│   └── Main.tscn          # Hauptszene mit VR-Setup
├── scripts/
│   ├── Main.gd            # Haupt-Manager für VR-Initialisierung
│   ├── WaveSystem.gd      # Dynamische Wellen-Simulation
│   ├── BeachEnvironment.gd # Strand und Umgebung
│   ├── SurferController.gd # Surfboard-Physik und -Bewegung
│   └── VRControllerManager.gd # VR-Controller-Eingaben
├── assets/                # Platz für 3D-Modelle, Texturen, Sounds
└── icons/
    └── icon.svg          # Projekt-Icon
```

## Entwicklungssetup

### Voraussetzungen
- Godot Engine 4.3+ mit OpenXR-Plugin aktiviert
- Meta Quest Development Setup
- Android SDK (für Quest-Builds)

### Erste Schritte
1. Öffne das Projekt in Godot Engine
2. Aktiviere das OpenXR-Plugin in den Projekteinstellungen
3. Stelle sicher, dass Android-Export-Templates installiert sind
4. Konfiguriere Android SDK-Pfad in den Editor-Einstellungen

### VR-Steuerung
- **Linker Thumbstick**: Lenkung links/rechts
- **Rechter Thumbstick**: Geschwindigkeitssteuerung vor/zurück
- **Linker Trigger**: Geschwindigkeitsschub (geplant)
- **Rechter Trigger**: Balance-Hilfe (geplant)  
- **Linker Grip**: Kamera-Follow umschalten
- **Rechter Grip**: Surfer-Position zurücksetzen

### Für Meta Quest exportieren
1. Gehe zu Projekt → Exportvorlagen verwalten
2. Lade Android-Export-Templates herunter
3. Konfiguriere Android-Export-Preset:
   - XR-Features: OpenXR aktivieren
   - Target SDK: 29+
   - Min SDK: 24+
4. Baue APK und installiere auf Meta Quest

## Nächste Entwicklungsschritte

### Kurzfristig (MVP-Verbesserungen)
- [ ] Schaum-Partikeleffekte bei Wellen-Bruch
- [ ] Verbessertes Surfboard-3D-Modell
- [ ] Einfache Soundeffekte (Wellen, Splash)
- [ ] Balance-Feedback (visuell/haptisch)

### Mittelfristig
- [ ] Surfboard-Auswahlmenü
- [ ] Verschiedene Wellen-Typen und -Größen
- [ ] Trick-System (Sprünge, Turns)
- [ ] Score-System mit Distanz/Zeit

### Langfristig
- [ ] Mehrere Strände/Levels
- [ ] Multiplayer-Unterstützung  
- [ ] Realistische Wasserphysik (FFT-basiert)
- [ ] Wind- und Wettereffekte

## Technische Details

### Wave System
- Mesh-Deformation mit kombinierten Sinus-Wellen
- Echtzeitberechnung von Wellen-Höhe und -Normalen
- Anpassbare Parameter: Stärke, Geschwindigkeit, Frequenz

### VR Integration
- OpenXR für plattformübergreifende VR-Kompatibilität
- Charakterkörper folgt Wellenoberfläche  
- Kamera-Rig mit sanftem Following und Tilting

### Performance-Optimierungen
- Mobile-Renderer für Quest-Kompatibilität
- Reduzierte Mesh-Auflösung für Leistung
- MSAA 2x für VR-Anti-Aliasing

## Bekannte Limitierungen

- Einfache Wellen-Physik (keine echte Fluid-Simulation)
- Grundlegendes Surfboard-Modell (Box-Mesh)
- Limitierte VR-Interaktionen
- Keine Sound/Musik-Integration
- Rudimentäres Umgebungs-Design

## Automatisierung & Workflow

- **Checks:** GitHub Actions (`.github/workflows/ci.yml`) lädt die Godot-CLI (4.3) im Headless-Modus und führt `godot --headless --path . --check-only` aus. Lokale Commits sollten denselben Befehl nutzen, um Syntaxfehler früh zu erkennen.
- **Releases:** Tags nach dem Muster `v*` triggern `.github/workflows/release.yml`. Der Job erzeugt eine `build/bininos_vr_surfer.pck` sowie ein Source-Tarball und veröffentlicht beides automatisch im GitHub-Release.
- **Erweiterungen:** Für signierte Android-/Quest-Builds müssen Android SDK, Export-Templates und Keystore-Secrets (`ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_ALIAS_PASSWORD`) im Repository hinterlegt werden. Danach kann der Release-Workflow um einen zusätzlichen Export-Schritt erweitert werden.
- **Copilot-Regeln:** Projektspezifische Hinweise für GitHub Copilot liegen in `.github/copilot-instructions.md` und beschreiben Build-, Test- und VR-spezifische Besonderheiten.

Diese MVP-Version bietet eine solide Grundlage für weiteres Prototyping und Feature-Entwicklung des VR-Surfing-Erlebnisses.