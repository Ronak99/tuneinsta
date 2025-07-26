import 'package:flutter/material.dart';

class DefaultTheme {
  static ThemeData get theme => ThemeData(
        fontFamily: 'SFUIText',
        scaffoldBackgroundColor: const Color(0xfff5f5f5),
        appBarTheme: AppBarTheme(
          color: Colors.brown.shade50,
          elevation: 0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.brown.shade100,
          foregroundColor: Colors.brown.shade900,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.brown.shade900,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.brown.shade500,
              width: .5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.brown.shade900,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.brown.shade500,
                width: .5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.brown.shade900,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          menuStyle: MenuStyle(
            elevation: WidgetStateProperty.all(1),
            visualDensity: const VisualDensity(horizontal: 2),
            backgroundColor: WidgetStateProperty.all(Colors.brown.shade50),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.brown.shade900,
          cursorColor: Colors.brown.shade900,
          selectionColor: Colors.brown.shade200,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors
                    .brown.shade200; // Change this to your desired ink color
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
