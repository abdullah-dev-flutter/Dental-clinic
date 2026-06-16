import 'package:flutter/material.dart';
import '../../widgets/common/app_bottom_nav.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;
  const ShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppBottomNav(child: child);
  }
}
