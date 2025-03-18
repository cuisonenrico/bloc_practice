import 'package:bloc_practice/state/models/time_log_model/time_log.dart';
import 'package:bloc_practice/state/models/time_log_repository/i_time_log_repository.dart';
import 'package:bloc_practice/state/models/time_log_repository/time_log_repository.dart';
import 'package:bloc_practice/state/substates/time_log_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class TimeLogCubit extends Cubit<TimeLogState> implements ITimeLogRepository {
  TimeLogCubit() : super(TimeLogState.init());

  @override
  Future<void> deleteTimeLog(int id) async {
    try {
      final box = await Hive.openBox<TimeLog>('TimeLogs');

      // Save employee in [DB]
      TimeLogRepository(box).deleteTimeLog(id);
      // await getTimeLogs(state);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Future<List<TimeLog>?> getTimeLogs(int id) async {
    final box = await Hive.openBox<TimeLog>('TimeLogs');

    // Loads all employees saved in DB
    final timeLogs = await TimeLogRepository(box).getTimeLogs(id);

    if (timeLogs == null) return null;

    // Store all employees in [DB] in [state]
    emit(state.copyWith(timeLogList: timeLogs));
    return timeLogs;
  }

  @override
  Future<void> saveTimeLog(TimeLog timeLog, int employeeId) async {
    try {
      final box = await Hive.openBox<TimeLog>('TimeLogs');

      final id = timeLog.id ?? box.length + 1;
      // Save employee in [DB]
      TimeLogRepository(box).saveTimeLog(
          timeLog.copyWith(
            id: id,
            employeeId: employeeId,
          ),
          employeeId);
      final timeLogs = state.timeLogList;

      // Store the employee in [state]
      emit(state.copyWith(timeLogList: [...timeLogs, timeLog]));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  void onChangeDate(DateTime date) =>
      emit(state.copyWith(selectedTimeLog: state.selectedTimeLog?.copyWith(date: date)));
  void onChangeTimeIn(DateTime timeIn) =>
      emit(state.copyWith(selectedTimeLog: state.selectedTimeLog?.copyWith(timeIn: timeIn)));
  void onChangeTimeOut(DateTime timeOut) =>
      emit(state.copyWith(selectedTimeLog: state.selectedTimeLog?.copyWith(timeOut: timeOut)));
  void onSetEmployeeId(int employeeId) =>
      emit(state.copyWith(selectedTimeLog: state.selectedTimeLog?.copyWith(employeeId: employeeId)));
  void onDisposeSelectedTimeLog(DateTime timeOut) => emit(state.copyWith(selectedTimeLog: TimeLog.init()));
}
