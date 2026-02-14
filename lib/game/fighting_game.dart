import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'components/background_component.dart';
import 'components/player_component.dart';
import 'components/enemy_component.dart';

class FightingGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'stage/bg.png',

      'player/idle.png',
      'player/walk.png',
      'player/punch.png',
      'player/block.png',
      'player/dead.png',

      'enemy/idle.png',
      'enemy/walk.png',
      'enemy/punch.png',
      'enemy/block.png',
      'enemy/dead.png',
    ]);

    add(BackgroundComponent());

    final player = PlayerComponent(Vector2(150, size.y - 40));
    final enemy = EnemyComponent(Vector2(size.x - 150, size.y - 40), player);

    addAll([player, enemy]);
  }
}
