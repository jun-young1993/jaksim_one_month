import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/extensions/app_exception.dart';
import 'package:jaksim_one_month/repository/home_repository.dart';
import 'package:jaksim_one_month/state/home/home_event.dart';
import 'package:jaksim_one_month/state/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc({required this.repository}) : super(HomeState.initilize()) {
    on<HomeEvent>(
      (event, emit) async {
        await event.map(
          initilize: (e) async {
            await _handleEvent(emit, () async {
              final user = await repository.getOrCreateUserInfo();
              emit(state.copyWith(user: user));
            });
          },
          clearError: (e) async {
            emit(state.copyWith(isLoading: false, error: null));
          },
        );
      },
    );
  }

  Future<void> _handleEvent<T>(
    Emitter<HomeState> emit,
    Future<T> Function() action, {
    AppException? defaultError,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await action();

      add(const HomeEvent.clearError());
    } on AppException catch (e) {
      print('🔥 [ERROR] AppException: $e');

      emit(state.copyWith(isLoading: false, error: e));
    } catch (e) {
      print('🔥 [ERROR] Unknown error: $e');

      emit(state.copyWith(
          isLoading: false,
          error: defaultError ?? AppException.unknown(e.toString())));
    }
  }
}
