import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/state/app/app_bloc.dart';
import 'package:flutter_common/state/app_config/app_config_bloc.dart';
import 'package:jaksim_one_month/repository/home_repository.dart';
import 'package:jaksim_one_month/state/home/home_bloc.dart';

class BlocProviderWrapper extends StatelessWidget {
  final Widget child;

  const BlocProviderWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppConfigBloc(),
        ),
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            repository: context.read<HomeRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
