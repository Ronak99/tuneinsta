import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final bool centerTitle;
  final Widget? fab;
  final Widget body;
  final PreferredSizeWidget? bottom;

  const CustomScaffold({
    super.key,
    required this.title,
    this.centerTitle = false,
    this.fab,
    this.bottom,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      floatingActionButton: fab,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.brown.shade900,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: bottom,
        centerTitle: centerTitle,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: body,
      ),
    );
  }
}
