import 'package:flutter/material.dart';
import '../models/bottom_nav_item.dart';

const List<BottomNavItem> commonNavItems = [
  BottomNavItem(
    route: '/',
    label: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  BottomNavItem(
    route: '/search',
    label: 'Search',
    icon: Icons.search_outlined,
    activeIcon: Icons.search,
  ),
  BottomNavItem(
    route: '/profile',
    label: 'Profile',
    icon: Icons.person_outline,
    activeIcon: Icons.person,
  ),
];