import 'package:bloc_practice/state/models/time_log_model/time_log.dart';
import 'package:bloc_practice/utilities/enums/error_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  factory AppState({
    @Default(ErrorCodes.STAND_BY) ErrorCodes errorCode,
    // Login
    @Default(false) bool isLoggedIn,

    // Time Log
    @Default([]) List<TimeLog> timeLogList,
    TimeLog? selectedTimeLog,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  factory AppState.init() => AppState();
}
