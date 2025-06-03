import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/repositories/goal_repository.dart';
import 'package:jaksim_one_month/repository/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryProviderWrapper extends StatelessWidget {
  final Widget child;
  final SharedPreferences prefs;

  const RepositoryProviderWrapper({
    super.key,
    required this.child,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeDefaultRepository(prefs: prefs),
        ),
        RepositoryProvider<GoalRepository>(
          create: (context) => GoalDefaultRepository(),
        ),
      ],
      child: child,
    );
  }
}
