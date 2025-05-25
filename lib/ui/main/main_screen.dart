import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/constants/index.dart';
import 'package:flutter_common/state/app/app_bloc.dart';
import 'package:flutter_common/state/app_config/app_config_bloc.dart';
import 'package:flutter_common/widgets/app/app_screen.dart';
import 'package:flutter_common/widgets/layout/setting_screen_layout.dart';
import 'package:jaksim_one_month/core/constants/app_constants.dart';
import 'package:jaksim_one_month/state/home/home_bloc.dart';
import 'package:jaksim_one_month/ui/home/home_screen.dart';
import 'package:jaksim_one_month/ui/setting/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomeBloc get homeBloc => context.read<HomeBloc>();
  AppBloc get appBloc => context.read<AppBloc>();
  AppConfigBloc get appConfigBloc => context.read<AppConfigBloc>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      bloc: appBloc,
      screens: [
        const HomeScreen(),
        SettingScreen(appConfigBloc: appConfigBloc),
      ],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppConstants.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppConstants.settings,
        ),
      ],
    );
  }
}
