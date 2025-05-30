import 'package:app/main.dart';
import 'package:app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: DefaultTheme.theme,
      routerConfig: router,
    );
  }
}
