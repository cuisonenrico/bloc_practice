import 'package:bloc_practice/state/models/time_log_model/time_log.dart';

abstract class ITimeLogRepository {
  Future<void> saveTimeLog(TimeLog timeLog, int employeeId);
  Future<List<TimeLog>?> getTimeLogs(int id);
  Future<void> deleteTimeLog(int id);
}
