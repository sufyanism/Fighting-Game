import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:get/get.dart';
import '../../controller/game_controller.dart';
import 'fighter_component.dart';
import 'player_component.dart';

class PunchHitBox extends RectangleComponent with CollisionCallbacks {
  final FighterComponent owner;
  final bool isPlayer;
  final controller = Get.find<GameController>();
  bool hit = false;

  // You can adjust these offsets based on your sprite size
  static final Vector2 hitboxSize = Vector2(40, 30);
  static final Vector2 offsetRight = Vector2(55, -45);
  static final Vector2 offsetLeft = Vector2(-55, -45);

  PunchHitBox({
    required this.owner,
    required this.isPlayer,
  }) : super(
    size: hitboxSize,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(collisionType: CollisionType.active));

    // Set initial position based on facing
    position = owner.position +
        (owner.facingRight ? offsetRight : offsetLeft);

    // Remove hitbox after short duration
    Future.delayed(const Duration(milliseconds: 120), removeFromParent);

    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Follow owner while still in game
    if (isMounted) {
      position = owner.position +
          (owner.facingRight ? offsetRight : offsetLeft);
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (hit) return;

    if (other is FighterComponent &&
        other != owner &&
        other.isAlive &&
        other.canBeHit) {

      hit = true;
      other.canBeHit = false;

      int dmg = 10;

      // Only player can block
      if (other is PlayerComponent &&
          other.blocking &&
          other.isFacing(owner)) {
        dmg = (dmg * other.blockDamageFactor).round();
      }

      if (isPlayer) {
        controller.damageEnemy(dmg);
      } else {
        controller.damagePlayer(dmg);
      }

      // Allow this fighter to be hit again after 300ms
      Future.delayed(const Duration(milliseconds: 300), () {
        other.canBeHit = true;
      });

      removeFromParent();
    }
  }
}
