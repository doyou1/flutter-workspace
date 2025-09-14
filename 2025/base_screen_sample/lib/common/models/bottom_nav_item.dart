import 'package:flutter/material.dart';

class BottomNavItem {
  final String route;
  final String label;
  final IconData icon;
  final IconData? activeIcon;

  const BottomNavItem({
    required this.route,
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}