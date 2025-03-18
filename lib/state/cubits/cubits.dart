import 'package:bloc_practice/state/app_state.dart';
import 'package:bloc_practice/utilities/enums/error_enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class StateCubit extends Cubit<AppState> {
  StateCubit() : super(AppState.init());

  // Fetch data from API
  // TODO(cuisonenrico): improve this by moving the API call to another file to better layer the structure
  Future<void> fetch() async {
    try {
      final response = await http.get(Uri.parse(''));

      if (response.statusCode == 200) {
        /// Parse object here (create a model and parse from json)
        // final data = json.decode(response.body);
        // emit(state.copyWith(text: 'data'));
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
