import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/extensions/app_exception.dart';
import 'package:flutter_common/state/app/app_bloc.dart';
import 'package:flutter_common/state/app/app_event.dart';
import 'package:jaksim_one_month/repository/home_repository.dart';
import 'package:jaksim_one_month/state/home/home_event.dart';
import 'package:jaksim_one_month/state/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  final AppBloc appBloc;
  HomeBloc({required this.repository, required this.appBloc})
      : super(HomeState.initilize()) {
    on<HomeEvent>(
      (event, emit) async {
        await event.map(
          initilize: (e) async {
            await _handleEvent(emit, () async {
              final user = await repository.getOrCreateUserInfo();
              emit(state.copyWith(user: user));
            });
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
    appBloc.add(const AppEvent.setLoading(true));
    try {
      await action();
      appBloc.add(const AppEvent.clearError());
    } on AppException catch (e) {
      print('🔥 [ERROR] AppException: $e');

      appBloc.add(AppEvent.setError(e));
    } catch (e) {
      print('🔥 [ERROR] Unknown error: $e');
      appBloc.add(AppEvent.setError(
          defaultError ?? AppException.unknown(e.toString())));
    }
  }
}
