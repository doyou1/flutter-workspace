import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist_youtube/config/config.dart';
import 'package:todolist_youtube/screen/screen.dart';

final navigationKey = GlobalKey<NavigatorState>();
final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  )
];
