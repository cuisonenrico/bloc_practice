import 'package:bloc_practice/state/models/time_log_model/time_log.dart';
import 'package:bloc_practice/state/models/time_log_repository/i_time_log_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITimeLogRepository)
class TimeLogRepository extends ITimeLogRepository {
  TimeLogRepository(this._timeLogBox);

  final Box<TimeLog> _timeLogBox;

  @override
  Future<void> deleteTimeLog(int id) async {
    if (_timeLogBox.containsKey(id)) await _timeLogBox.delete(id);
    return;
  }

  @override
  Future<List<TimeLog>?> getTimeLogs(int id) async {
    final timeLogs = _timeLogBox.values.toList();
    return timeLogs.where((timeLog) => timeLog.employeeId == id).toList();
  }

  @override
  Future<void> saveTimeLog(TimeLog timeLog, int employeeId) async {
    try {
      await _timeLogBox.put(timeLog.id, timeLog);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return;
  }
}
