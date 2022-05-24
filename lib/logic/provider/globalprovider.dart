import 'package:flutter/material.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';

class GlobalProvider extends ChangeNotifier {
  List<CharaterModels> favorite = [];
  bool _isFalorite = false;
  bool filterVisible = false;

  bool get isFavorite => _isFalorite;

  set changeFavorite(bool v) {
    _isFalorite = v;
    notifyListeners();
  }

  void changeFilter(bool v) {
    filterVisible = v;
    notifyListeners();
  }

  void changeFavoriteAdd(CharaterModels v){
    favorite.add(v);
    
    notifyListeners();
  }

  void changeFavoriteDelete(CharaterModels v){
    favorite.remove(v);
    notifyListeners();
  }

  bool keyExist(CharaterModels v){
   return favorite.contains(v);
  }
}
