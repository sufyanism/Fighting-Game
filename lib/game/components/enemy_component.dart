import 'dart:math';
import 'package:flame/components.dart';
import 'package:get/get.dart';
import '../../controller/game_controller.dart';
import '../enums/fighter_state.dart';
import 'fighter_component.dart';
import 'player_component.dart';
import 'punch_hit_box.dart';

class EnemyComponent extends FighterComponent {
  final PlayerComponent target;
  final rnd = Random();
  double attackCooldown = 0;

  EnemyComponent(super.position, this.target);

  @override
  Future<void> onLoad() async {
    animations = {
      FighterState.idle: await loadAnim('enemy/idle.png', 2),
      FighterState.walk: await loadAnim('enemy/walk.png', 5),
      FighterState.punch: await loadAnim('enemy/punch.png', 4, loop: false),
      FighterState.dead: await loadAnim('enemy/dead.png', 4, loop: false),
    };

    animation = animations[FighterState.idle];
    blocking = false; // AI never blocks
    Get.find<GameController>().registerEnemy(this);
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isAlive || attacking) return;

    attackCooldown -= dt;

    final dx = target.position.x - position.x;
    final dist = dx.abs();
    updateFacing(dx);

    if (attackCooldown > 0) return;

    if (dist > 120) {
      position.x += dx.sign * speed * dt;

      // Only walk if not attacking
      if (!attacking) setState(FighterState.walk);
    } else {
      attack();
      attackCooldown = 0.8;
    }
  }

  @override
  void attack() {
    if (!isAlive || attacking) return;

    attacking = true;
    setState(FighterState.punch);

    gameRef.add(PunchHitBox(owner: this, isPlayer: false));

    // After punch finishes, go back to idle
    Future.delayed(const Duration(milliseconds: 450), () {
      attacking = false;
      if (isAlive) setState(FighterState.idle);
    });
  }
}
