import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/extensions/app_exception.dart';
import 'package:flutter_common/models/user/user.dart';
import 'package:jaksim_one_month/state/home/home_bloc.dart';
import 'package:jaksim_one_month/state/home/home_state.dart';

class HomeSelector<T> extends BlocSelector<HomeBloc, HomeState, T> {
  const HomeSelector({
    super.key,
    required super.selector,
    required super.builder,
  });
}

class ExceptionSelector extends HomeSelector<AppException?> {
  ExceptionSelector(Widget Function(AppException? exception) builder,
      {super.key})
      : super(
          selector: (state) => state.error,
          builder: (context, exception) => builder(exception),
        );
}

class UserSelector extends HomeSelector<User?> {
  UserSelector(Widget Function(User? user) builder, {super.key})
      : super(
          selector: (state) => state.user,
          builder: (context, user) => builder(user),
        );
}
