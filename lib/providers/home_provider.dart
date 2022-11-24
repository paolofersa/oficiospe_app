import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oficiospe_app_employee/models/worker.dart';
import 'package:oficiospe_app_employee/services/authentication.dart';
import 'package:oficiospe_app_employee/services/database.dart';

class HomeProvider with ChangeNotifier {
  int _bottomNavIndex = 1;
  Worker _user = Worker.empty();
  bool _favoriteHandler = true;
  bool _loading = false;

  final ScrollController nearPageScrollController = ScrollController();
  final ScrollController searchPageScrollController = ScrollController();

  int get bottomNavIndex => _bottomNavIndex;

  set bottomNavIndex(int index) {
    if (_bottomNavIndex == index) {
      switch (index) {
        case 0:
          nearPageScrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 250),
            curve: standardEasing,
          );
          break;
        case 1:
          searchPageScrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 250),
            curve: standardEasing,
          );
          break;
      }
    } else {
      _bottomNavIndex = index;
    }

    notifyListeners();
  }

  Future<void> initialize() async {
    try {
      _loading = true;
      if (authentication.firebasAuth.currentUser != null) {
        if (!authentication.firebasAuth.currentUser!.isAnonymous) {
          _user = await database
              .getworker(authentication.firebasAuth.currentUser!.uid);
        }
      }
      _loading = false;
    } on Exception {
      rethrow;
    }
  }

  Worker get user => _user;

  bool get isLoading => _loading;

  void changedFavorites() {
    notifyListeners();
  }

  set favoriteHandler(bool newHandler) {
    _favoriteHandler = newHandler;
    if (newHandler) {
      notifyListeners();
    }
  }

  bool get favoriteHandler => _favoriteHandler;
}
