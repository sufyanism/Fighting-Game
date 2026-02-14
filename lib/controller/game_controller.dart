import 'package:get/get.dart';
import '../game/components/player_component.dart';
import '../game/components/enemy_component.dart';

class GameController extends GetxController {
  final playerHealth = 100.obs;
  final enemyHealth = 100.obs;

  final gameOver = false.obs;
  final playerWon = false.obs;
  final playerReady = false.obs;

  PlayerComponent? player;
  EnemyComponent? enemy;

  void registerPlayer(PlayerComponent p) {
    player = p;
    playerReady.value = true;
  }

  void registerEnemy(EnemyComponent e) {
    enemy = e;
  }

  void damagePlayer(int dmg) {
    if (gameOver.value) return;

    playerHealth.value = (playerHealth.value - dmg).clamp(0, 100);

    if (playerHealth.value == 0) {
      player?.die();
      gameOver.value = true;
      playerWon.value = false;
    }
  }

  void damageEnemy(int dmg) {
    if (gameOver.value) return;

    enemyHealth.value = (enemyHealth.value - dmg).clamp(0, 100);

    if (enemyHealth.value == 0) {
      enemy?.die();
      gameOver.value = true;
      playerWon.value = true;
    }
  }

  void move(int dir) => player?.setMove(dir.toDouble());
  void stop() => player?.setMove(0);
  void punch() => player?.attack();

  // ✅ FIXED BLOCK
  void block(bool v) {
    if (v) {
      player?.startBlock();
    } else {
      player?.stopBlock();
    }
  }

  void reset() {
    playerHealth.value = 100;
    enemyHealth.value = 100;
    gameOver.value = false;
    playerWon.value = false;
    playerReady.value = false;
    player = null;
    enemy = null;
  }
}
