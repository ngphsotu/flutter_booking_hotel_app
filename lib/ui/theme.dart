import 'package:flutter/material.dart';

import 'ui.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData themeData;
  ThemeChanger({required this.themeData});
  getTheme() => themeData;
  setTheme(int dark) {
    if (dark == 0) {
      themeData = ThemeData.dark().copyWith(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.black,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.white),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: AppColors.primaryColor),
      );
    } else {
      themeData = ThemeData.light().copyWith(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.black),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: AppColors.primaryColor),
      );
    }
    notifyListeners();
  }
}
