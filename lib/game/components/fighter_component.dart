import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../fighting_game.dart';
import '../enums/fighter_state.dart';

abstract class FighterComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<FightingGame> {
  FighterComponent(Vector2 position)
      : super(
    position: position,
    size: Vector2(96, 140),
    scale: Vector2.all(1.5),
    anchor: Anchor.bottomCenter,
  );

  late Map<FighterState, SpriteAnimation> animations;
  FighterState state = FighterState.idle;

  bool attacking = false;
  bool blocking = false;
  bool isAlive = true;
  bool canBeHit = true;
  bool facingRight = true;

  bool animationLocked = false; // locks current animation
  FighterState? fallbackState;  // state to go after animation finishes

  double speed = 150;
  double blockDamageFactor = 0.3;

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    await super.onLoad();
  }

  Future<SpriteAnimation> loadAnim(
      String path,
      int frames, {
        bool loop = true,
        double stepTime = 0.1,
      }) async {
    final img = await game.images.load(path);

    final anim = SpriteAnimation.fromFrameData(
      img,
      SpriteAnimationData.sequenced(
        amount: frames,
        stepTime: stepTime,
        textureSize: size,
        loop: loop,
      ),
    );

    // Store the total duration for non-looping animations
    animationDurations[anim] = loop ? double.infinity : frames * stepTime;

    return anim;
  }

// Map to track durations
  final Map<SpriteAnimation, double> animationDurations = {};
  double animationProgress = 0.0;

  @override
  void update(double dt) {
    super.update(dt);
    if (animation == null) return;

    // Increment progress
    animationProgress += dt;

    // Check if locked, non-looping animation finished
    if (animationLocked &&
        animationDurations[animation!] != null &&
        animationProgress >= animationDurations[animation!]!) {
      animationLocked = false;
      animationProgress = 0.0;

      if (fallbackState != null) {
        setState(fallbackState!);
        fallbackState = null;
      }
    }
  }

  void setState(FighterState s, {bool lockAnimation = false, FighterState? after}) {
    if (!isAlive && s != FighterState.dead) return;
    if (state == s) return;
    if (animationLocked) return;

    state = s;
    animation = animations[s];
    animationLocked = lockAnimation;
    fallbackState = after;

    // Reset progress
    animationProgress = 0.0;
  }



  void updateFacing(double dir) {
    if (dir == 0) return;
    facingRight = dir > 0;
    scale.x = facingRight ? 1 : -1;
  }

  bool isFacing(FighterComponent other) {
    return facingRight
        ? other.position.x > position.x
        : other.position.x < position.x;
  }

  void die() {
    if (!isAlive) return;
    isAlive = false;
    attacking = false;
    blocking = false;
    canBeHit = false;
    setState(FighterState.dead, lockAnimation: true);
  }

  void attack();
}
