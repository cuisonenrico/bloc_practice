import 'package:bloc_practice/state/models/time_log_model/time_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_log_state.freezed.dart';
part 'time_log_state.g.dart';

@freezed
class TimeLogState with _$TimeLogState {
  factory TimeLogState({
    @Default('') String nameQuery,
    @Default([]) List<TimeLog> timeLogList,
    @Default([]) List<TimeLog> filteredTimeLogList,
    @Default(null) TimeLog? selectedTimeLog,
  }) = _TimeLogState;

  factory TimeLogState.fromJson(Map<String, dynamic> json) => _$TimeLogStateFromJson(json);

  factory TimeLogState.init() => TimeLogState(selectedTimeLog: TimeLog.init());
}
