import 'package:flutter/material.dart';
import 'package:jaksim_one_month/app.dart';
import 'package:jaksim_one_month/core/di/bloc_provider_wrapper.dart';
import 'package:jaksim_one_month/core/di/repository_provider_wrapper.dart';

void main() {
  runApp(
    RepositoryProviderWrapper(child: BlocProviderWrapper(child: const MyApp())),
  );
}
