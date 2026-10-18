# OAC Kirby

An academic game project written in RISC-V Assembly and inspired by *Kirby's Adventure* (NES). It demonstrates character movement and animation, collision detection, and map rendering to a framebuffer.

## Features

- Two levels, each with its own map and collision data.
- Horizontal movement and map scrolling.
- Jumping and falling with character state updates.
- Kirby animations facing left and right.
- Tile-based rendering of the scenery and character to the framebuffer.

## Controls

| Key | Action |
| --- | --- |
| `A` | Move left |
| `D` | Move right |
| `W` | Jump |
| `E` | Advance to the second level |

## Running the game

The project was developed for the FPGRARS simulator. From the repository root, run:

```sh
.\tools\fpgrars-x86_64-pc-windows-msvc--unb.exe main.s
```

Include paths are relative to the repository root, so keep the root as the working directory when using the simulator or another FPGRARS distribution. The bundled executable is for Windows; on other operating systems, use a compatible version of the simulator.

## Repository structure

```text
.
├── assets/
│   ├── maps/       # Visual maps and collision data for each level
│   └── tiles/      # Scenery tiles and Kirby sprites
├── examples/       # Standalone music routine
├── src/            # Game logic, input, state management, and rendering
├── tools/          # FPGRARS executable for Windows
├── archive/        # Older jump routine, not used by the game
└── main.s          # Entry point; includes the project modules
```

## Key files

- [`main.s`](main.s): game initialization and main loop.
- [`src/keyboard.s`](src/keyboard.s): keyboard input, movement, and level transitions.
- [`src/controleEstados.s`](src/controleEstados.s), [`src/checaSubindo.s`](src/checaSubindo.s), and [`src/checaCaindo.s`](src/checaCaindo.s): character states and vertical movement.
- [`src/print_map.s`](src/print_map.s) and [`src/print_tile.s`](src/print_tile.s): map and tile rendering.
- [`assets/maps/`](assets/maps/): visual maps and collision matrices for both levels.
- [`assets/tiles/`](assets/tiles/): graphics used by the game.
- [`examples/music.s`](examples/music.s): a standalone music routine, not included in the main game.

## Technologies

- Assembly RISC-V
- FPGRARS simulator
- Git
