import 'package:flutter/material.dart';
import 'package:flutter_common/constants/juny_constants.dart';
import 'package:flutter_common/state/app_config/app_config_bloc.dart';
import 'package:flutter_common/widgets/layout/setting_screen_layout.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key, required this.appConfigBloc});
  final AppConfigBloc appConfigBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: SettingScreenLayout(
          appConfigBloc: appConfigBloc, appKey: AppKeys.jaksimOneMonth),
    );
  }
}
