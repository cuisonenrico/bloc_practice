import 'package:bloc_practice/state/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateCubit extends Cubit<AppState> {
  StateCubit() : super(AppState.init());

  void increment() => emit(state.copyWith(counter: state.counter + 1));
  void decrement() => emit(state.copyWith(counter: state.counter - 1));
  void setText(String text) => emit(state.copyWith(text: text));
}
