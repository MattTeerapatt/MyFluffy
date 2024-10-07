import 'package:myfluffy/model/class.dart';

class TileContext {
  TileStrategy? strategy;

  TileContext(this.strategy);

  void displayTile() {
    strategy?.displayTile();
  }

  void setStrategy(TileStrategy newStrategy) {
    strategy = newStrategy;
  }
}
