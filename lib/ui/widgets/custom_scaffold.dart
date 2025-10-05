import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final bool centerTitle;
  final Widget? fab;
  final Widget body;
  final PreferredSizeWidget? bottom;
  final List<Widget> actions;
  final VoidCallback? onTitleTap;

  const CustomScaffold({
    super.key,
    required this.title,
    this.centerTitle = false,
    this.fab,
    this.bottom,
    this.actions = const [],
    required this.body,
    this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      floatingActionButton: fab,
      appBar: AppBar(
        title: GestureDetector(
          onTap: onTitleTap,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.brown.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: actions,
        bottom: bottom,
        centerTitle: centerTitle,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}
