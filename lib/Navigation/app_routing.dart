import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_ui/Navigation/paths.dart';
import 'package:todo_app_ui/screens.dart/dashboard_screen.dart';
import 'package:todo_app_ui/screens.dart/login_screen.dart';
import 'package:todo_app_ui/screens.dart/registor_screen.dart';
import 'package:todo_app_ui/screens.dart/splash.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: RoutePaths.splash,
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: RoutePaths.register,
          builder: (BuildContext context, GoRouterState state) {
            return RegistorScreen();
          },
        ),
        GoRoute(
          path: RoutePaths.loginaPage,
          builder: (BuildContext context, GoRouterState state) {
            return LoginScreen();
          },
        ),
        GoRoute(
          path: RoutePaths.dashboard,
          builder: (BuildContext context, GoRouterState state) {
            return DashboardScreen();
          },
        ),
      ],
    ),
  ],
);
