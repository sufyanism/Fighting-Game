import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/game_controller.dart';

class GameUI extends StatelessWidget {
  const GameUI({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GameController>();

    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Obx(() => Row(
        children: [
          Expanded(child: bar(c.playerHealth.value, Colors.green)),
          const SizedBox(width: 20),
          Expanded(child: bar(c.enemyHealth.value, Colors.red)),
        ],
      )),
    );
  }

  Widget bar(int v, Color color) => Container(
    height: 14,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      color: Colors.black,
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: v.toDouble() / 100.0, // ✅ FIX
      child: Container(color: color),
    ),
  );
}
