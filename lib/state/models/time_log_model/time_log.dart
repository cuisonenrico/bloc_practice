import 'package:bloc_practice/state/models/employee_model/employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_log.freezed.dart';
part 'time_log.g.dart';

@freezed
class TimeLog with _$TimeLog {
  factory TimeLog({
    DateTime? timeIn,
    DateTime? timeOut,
    Employee? employee,
  }) = _TimeLog;

  factory TimeLog.fromJson(Map<String, dynamic> json) => _$TimeLogFromJson(json);
}
