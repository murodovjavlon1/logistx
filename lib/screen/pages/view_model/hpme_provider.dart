import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HomeProvider with ChangeNotifier {
  SampleItem? _selectedItem;

  SampleItem? get selectedItem => _selectedItem;

  void selectItem(SampleItem item) {
    _selectedItem = item;
    notifyListeners(); 
  }
}
