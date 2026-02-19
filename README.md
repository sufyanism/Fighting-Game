# Fight Game – Flutter + Flame Fighting Game
A 2D fighting game built using Flutter, Flame Engine, and GetX state management. The game features a player vs AI enemy battle system with animations, hit detection, health system, mobile controls, and reactive UI overlays.

## Project Overview
- Built with Flutter and Flame game engine
- Uses GetX for state management and reactive UI
- Player vs Enemy AI combat
- Animation-based fighting mechanics
- Health system and result screen

## Core Features
### Game Mechanics
- Player movement (left/right)
- Punch attack system
- Blocking mechanic (damage reduction)
- Enemy AI with distance-based attack logic
- Collision-based hit detection
- Game over and restart system

## UI Features
- Health bars for player and enemy
- Mobile touch controls
- Win/Lose overlay screen
- Restart button using GetX navigation

## Architecture
Controller Layer
- GameController: manages health, combat logic, and game state

## Game Components
- FighterComponent: base class for fighters
- PlayerComponent: handles player actions
- EnemyComponent: AI enemy behavior
- PunchHitBox: collision and damage detection
- BackgroundComponent: dynamic stage background

## Game Engine
- FightingGame: FlameGame implementation
- Handles asset loading and component setup

## State Management
- Reactive variables using GetX (RxInt, RxBool)
- Observers update UI automatically

## Project Structure
```plaintext
lib/
├── controller/
│   └── game_controller.dart
├── game/
│   ├── components/
│   ├── enums/
│   └── fighting_game.dart
├── ui/
│   ├── game_screen.dart
│   ├── game_ui.dart
│   └── mobile_controls.dart
└── main.dart
```

## Gameplay Flow
1. Game loads assets and background
2. Player and enemy spawn
3. Player uses mobile controls to move and punch
4. Enemy AI approaches and attacks automatically
5. Hitboxes detect collisions and apply damage
6. Game ends when one health reaches zero

## Technologies Used
- Flutter
- Flame Engine
- GetX
- Sprite Animations
- Collision Detection

## Getting Started
1. Install dependencies
   flutter pub get

2. Run the game
   flutter run

## Assets Required
- stage/bg.png
- player animations (idle, walk, punch, block, dead)
- enemy animations (idle, walk, punch, dead)

## About Me 
✨ I’m **Sufyan bin Uzayr**, an open-source developer passionate about building and sharing meaningful projects.
You can learn more about me and my work at [sufyanism.com](https://sufyanism.com/) or connect with me on [Linkedin](https://www.linkedin.com/in/sufyanism)

## Your all-in-one learning hub! 
🚀 Explore courses and resources in coding, tech, and development at **zeba.academy** and **code.zeba.academy**. Empower yourself with practical skills through curated tutorials, real-world projects, and hands-on experience. Level up your tech game today! 💻✨

**Zeba Academy**  is a learning platform dedicated to **coding**, **technology**, and **development**.  
➡ Visit our main site: [zeba.academy](https://zeba.academy)   </br>
➡ Explore hands-on courses and resources at: [code.zeba.academy](https://code.zeba.academy)   </br>
➡ Check out our YouTube for more tutorials: [zeba.academy](https://www.youtube.com/@zeba.academy)  </br>
➡ Follow us on Instagram: [zeba.academy](https://www.instagram.com/zeba.academy/)  </br>

**Thank you for visiting!**
