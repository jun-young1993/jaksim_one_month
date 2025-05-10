import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksim_one_month/core/di/home_repository.dart';

class RepositoryProviderWrapper extends StatelessWidget {
  final Widget child;

  const RepositoryProviderWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeDefaultRepository(),
        ),
      ],
      child: child,
    );
  }
}
