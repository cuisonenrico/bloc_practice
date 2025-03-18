import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'time_log.freezed.dart';
part 'time_log.g.dart';

@freezed
class TimeLog with _$TimeLog {
  @HiveType(typeId: 2)
  factory TimeLog({
    @HiveField(0) int? id,
    @HiveField(1) int? employeeId,
    @HiveField(2) DateTime? timeIn,
    @HiveField(3) DateTime? timeOut,
    @HiveField(4) DateTime? date,
  }) = _TimeLog;

  factory TimeLog.fromJson(Map<String, dynamic> json) => _$TimeLogFromJson(json);
  factory TimeLog.init() => TimeLog();
}
