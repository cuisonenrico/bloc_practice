import 'package:bloc_practice/state/app_state.dart';
import 'package:bloc_practice/utilities/enums/error_enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class StateCubit extends Cubit<AppState> {
  StateCubit() : super(AppState.init());

  void increment() => emit(state.copyWith(counter: state.counter + 1));
  void decrement() => emit(state.copyWith(counter: state.counter - 1));
  void setText(String text) => emit(state.copyWith(text: text));
  // Fetch data from API
  Future<void> fetch() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        // final data = json.decode(response.body);
        emit(state.copyWith(text: 'data'));
      } else {
        emit(state.copyWith(errorCode: ErrorCodes.API_ERROR));
      }
    } catch (e) {
      emit(state.copyWith(errorCode: ErrorCodes.HANDLING_ERROR));
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
