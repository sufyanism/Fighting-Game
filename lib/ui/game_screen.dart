import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import '../controller/game_controller.dart';
import '../game/fighting_game.dart';
import 'game_ui.dart';
import 'mobile_controls.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = FightingGame();

    return Scaffold(
      body: Stack(
        children: [
          // 1️⃣ Flame game
          GameWidget(
            game: game,
          ),

          // 2️⃣ UI overlays
          const GameUI(),
          const MobileControls(),

          // 3️⃣ Result overlay
          const ResultOverlay(),
        ],
      ),
    );
  }
}

class ResultOverlay extends StatelessWidget {
  const ResultOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GameController>();

    return Obx(() {
      if (!c.gameOver.value) return const SizedBox.shrink();

      return Container(
        color: Colors.black87,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                c.playerWon.value ? "YOU WIN 🏆" : "YOU LOSE ☠️",
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () {
                  c.reset();

                  // 🔁 RESTART GAME SCREEN
                  Get.off(() => const GameScreen());
                },
                child: const Text(
                  "RESTART",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
