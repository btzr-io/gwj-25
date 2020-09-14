
# Game design document

A simple game design document for the [Godot wild jam #25](https://itch.io/jam/godot-wild-jam-25) event.

### Index
1. [Theme](#theme)
1. [Wildcards](#wildcards)
1. [Story](#story)
1. [Characters](#characters)
1. [Gameplay](#gameplay)
1. [Game Controls](#game-controls)
1. [Project structure](#project-structure)
1. [Level/enviroment design](#levelenvironment-design)
1. [Art](#art)
1. [Sound and Music](#sound-and-music)


## Theme
<img src="https://img.itch.zone/aW1nLzQyMjQyNjkucG5n/original/er%2BJth.png" width="50%"/>

### Wildcards
> Wildcards are an optional limitation to add a unique challenge in addition to the theme.
Pick one or pick all. It's up to you. Wildcards are revealed at the same 
time as the theme, and there are always only 3. Ignoring wildcards completely will not incur a deduction in judging.

<img src="https://img.itch.zone/aW1nLzQyMjQyNzkucG5n/original/VwakEU.png" width="50%"/>

### Selected wild cards:
- [x] HUD Less
- [ ] Traditionalist.
- [ ] Forbidden Fruit.

## Story

Time traveler from dystopian future and  you trying to prevent global catastrophe which leads to this kind of future. Seeking a way to close the portals that bring the corruption to the world.

## Characters
TBD

## Level/environment design

TBD

## Gameplay

- 2D platform movement with double jump.
- Objective is to get "key" to close the portal.

Player can toggle between 2 states: Light (default) and Dark.

#### Light mode:

Default mode. Player can interact in the current world and is unable to see or interact with dark dimension.

#### Dark mode:

When this state is selected the player would have an aurea / area that will expand and move around the character.
This state allows the player to see hidden objects, obstacles, etc..

#### Obstacles:

TBD

#### Objects / items:

TBD

## Game Controls
| Action | Input | Description |
| ------ | ----- | ----------- |
| player_move_left | Keyboard key: `A` | Move player to the left... |
| player_move_right  | Keyboard key: `S` | Move player to the right... |
| player_jump  | Keyboard key: `W` | Jump, press twice to doulble jump... |
| player_toggle  | Keyboard key: `SPACE` | Toggle mode: Light / Dark ... |

## Project structure
>
> - assets
>   - sprites / images
>   - music / sound fx
>   - fonts
>   - ...
> - scenes
>   - Level
>   - ...
> - scripts
>   - Autoload / Global
>   - ...


## Art
TBD
## Sound and Music
TBD

