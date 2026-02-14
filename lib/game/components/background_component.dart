import 'package:flame/components.dart';
import '../fighting_game.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<FightingGame> {

  @override
  Future<void> onLoad() async {
    sprite = Sprite(await gameRef.images.load('stage/bg.png'));

    // Initially fill the screen
    size = gameRef.size;
    position = Vector2.zero();
    anchor = Anchor.topLeft;
    priority = 0;

    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Continuously match the game size (handles orientation change)
    if (size != gameRef.size) {
      size = gameRef.size;
    }
  }
}
