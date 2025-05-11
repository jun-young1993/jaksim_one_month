import 'package:flutter_common/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jaksim_one_month/exceptions/app_exception.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default(null) AppException? error,
    @Default(null) User? user,
  }) = _HomeState;

  factory HomeState.initilize() => const HomeState();
}
