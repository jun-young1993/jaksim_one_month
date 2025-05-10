import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksim_one_month/state/home/home_event.dart';
import 'package:jaksim_one_month/state/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initilize()) {
    on<HomeEvent>((event, emit) {
      event.map(initilize: (e) => _onInitilize(e, emit));
    });
  }

  void _onInitilize(HomeEvent event, Emitter<HomeState> emit) {
    try {
      // 초기화 로직 구현
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
  }
}
