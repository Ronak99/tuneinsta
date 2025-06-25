import 'package:app/route_generator.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackbar({required String text}) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(RouteGenerator.context).showSnackBar(snackBar);
  }
}