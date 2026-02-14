import 'package:flame/components.dart';
import 'package:get/get.dart';
import '../../controller/game_controller.dart';
import '../enums/fighter_state.dart';
import 'fighter_component.dart';
import 'punch_hit_box.dart';

class PlayerComponent extends FighterComponent {
  PlayerComponent(super.position);

  final controller = Get.find<GameController>();
  double moveDir = 0;

  @override
  Future<void> onLoad() async {
    animations = {
      FighterState.idle: await loadAnim('player/idle.png', 3),
      FighterState.walk: await loadAnim('player/walk.png', 6),
      FighterState.punch: await loadAnim('player/punch.png', 4, loop: false),
      FighterState.block: await loadAnim('player/block.png', 2),
      FighterState.dead: await loadAnim('player/dead.png', 3, loop: false),
    };

    animation = animations[FighterState.idle];
    controller.registerPlayer(this);
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isAlive) return;

    if (attacking || blocking || animationLocked) return;

    // Movement
    position.x += moveDir * speed * dt;
    updateFacing(moveDir);

    // Only change state if not attacking/blocking
    final newState = moveDir.abs() < 0.1 ? FighterState.idle : FighterState.walk;
    setState(newState);
  }

  void startBlock() {
    if (!isAlive || attacking) return;
    blocking = true;
    setState(FighterState.block);
  }

  void stopBlock() {
    blocking = false;
    if (isAlive && !attacking) {
      setState(FighterState.idle);
    }
  }

  @override
  void attack() {
    if (!isAlive || attacking || blocking) return;

    attacking = true;
    setState(FighterState.punch, lockAnimation: true); // 🔒 lock punch animation

    gameRef.add(PunchHitBox(owner: this, isPlayer: true));

    Future.delayed(const Duration(milliseconds: 400), () {
      attacking = false;
      animationLocked = false; // unlock animation
      if (isAlive && !blocking) {
        final fallbackState = moveDir.abs() < 0.1 ? FighterState.idle : FighterState.walk;
        setState(fallbackState);
      }
    });
  }

  void setMove(double v) => moveDir = v.clamp(-1, 1);
}
