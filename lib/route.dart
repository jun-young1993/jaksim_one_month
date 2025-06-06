import 'package:flutter/material.dart';
import 'package:flutter_common/models/goal/goal.dart';
import 'package:flutter_common/widgets/fade_route.dart';
import 'package:jaksim_one_month/ui/screens/goal_detail_screen.dart';
import 'package:jaksim_one_month/ui/main/main_screen.dart';

enum Routes { home, login, signup, main, goalDetail }

class _Paths {
  static const String home = "/home";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String main = "/main";
  static const String goalDetail = "/goalDetail";

  static const Map<Routes, String> pathMap = {
    Routes.home: _Paths.home,
    Routes.login: _Paths.login,
    Routes.signup: _Paths.signup,
    Routes.main: _Paths.main,
    Routes.goalDetail: _Paths.goalDetail,
  };

  static String of(Routes route) => pathMap[route]!;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    AppNavigator.currentRoute = settings.name;
    switch (settings.name) {
      case _Paths.goalDetail:
        if (settings.arguments is Goal) {
          return FadeRoute(
            page: GoalDetailScreen(goal: settings.arguments as Goal),
          );
        }
        return FadeRoute(page: const MainScreen());
      default:
        return FadeRoute(page: const MainScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;

  static String? currentRoute;
}
