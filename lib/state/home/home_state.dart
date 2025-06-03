import 'package:flutter_common/extensions/app_exception.dart';
import 'package:flutter_common/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default(null) AppException? error,
    @Default(null) User? user,
  }) = _HomeState;

  factory HomeState.initialize() => const HomeState();
}
