import 'package:flutter/material.dart';

class DefaultTheme {
  static ThemeData get theme => ThemeData(
        fontFamily: 'SFUIText',
        scaffoldBackgroundColor: const Color(0xfff5f5f5),
        appBarTheme: AppBarTheme(
          color: Colors.brown.shade50,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.brown.shade200; // Change this to your desired ink color
              }
              return null; // Use default color otherwise
            }),
            elevation: const WidgetStatePropertyAll<double>(0),
            backgroundColor:
                WidgetStatePropertyAll<Color>(Colors.brown.shade100),
            foregroundColor:
                WidgetStatePropertyAll<Color>(Colors.brown.shade800),
            textStyle: WidgetStatePropertyAll<TextStyle>(
              TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.brown.shade800,
                fontFamily: 'SFUIText',
              ),
            ),
          ),
        ),
      );
}
