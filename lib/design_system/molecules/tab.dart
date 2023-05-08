import 'package:flutter/material.dart';

class AppTab extends StatelessWidget {

  final String tabText;

  const AppTab({
    super.key,
    required this.tabText,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          tabText,
        ),
      ),
    );
  }
}