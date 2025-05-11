import 'package:flutter/material.dart';
import 'package:jaksim_one_month/app.dart';
import 'package:jaksim_one_month/core/di/bloc_provider_wrapper.dart';
import 'package:jaksim_one_month/core/di/repository_provider_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    RepositoryProviderWrapper(
      prefs: prefs,
      child: const BlocProviderWrapper(child: MyApp()),
    ),
  );
}
