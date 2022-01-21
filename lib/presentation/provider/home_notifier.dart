import 'package:core/core.dart' show DrawerItem;
import 'package:flutter/foundation.dart';

class HomeNotifier extends ChangeNotifier {
  DrawerItem _selectedDrawerItem = DrawerItem.movie;
  DrawerItem get selectedDrawerItem => _selectedDrawerItem;

  void setSelectedDrawerItem(DrawerItem newItem) {
    this._selectedDrawerItem = newItem;
    notifyListeners();
  }
}
