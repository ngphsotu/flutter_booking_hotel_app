import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/ui.dart';
import 'splash/splash.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(
        themeData: ThemeData.light().copyWith(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: AppColors.primaryColor),
          textSelectionTheme:
              const TextSelectionThemeData(selectionColor: Colors.black),
        ),
      ),
      child: const AppTheme(),
    );
  }
}

class AppTheme extends StatelessWidget {
  const AppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: const SplashPage(),
    );
  }
}
