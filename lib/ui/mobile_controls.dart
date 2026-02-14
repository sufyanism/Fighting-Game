import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/game_controller.dart';

class MobileControls extends StatelessWidget {
  const MobileControls({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GameController>();

    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Obx(() {
        // ✅ Now using a REAL observable
        if (!c.playerReady.value) {
          return const SizedBox.shrink();
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _btn(
                  icon: Icons.arrow_back,
                  onDown: () => c.move(-1),
                  onUp: c.stop,
                ),
                const SizedBox(width: 16),
                _btn(
                  icon: Icons.arrow_forward,
                  onDown: () => c.move(1),
                  onUp: c.stop,
                ),
              ],
            ),
            _btn(
              icon: Icons.sports_mma,
              onDown: c.punch,
            ),
          ],
        );
      }),
    );
  }

  Widget _btn({
    required IconData icon,
    required VoidCallback onDown,
    VoidCallback? onUp,
  }) {
    return GestureDetector(
      onTapDown: (_) => onDown(),
      onTapUp: (_) => onUp?.call(),
      onTapCancel: () => onUp?.call(),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
