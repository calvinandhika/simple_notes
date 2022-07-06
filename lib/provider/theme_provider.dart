import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  void setDefaultTheme(bool isDark) {
    _isDark = isDark;
  }

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
