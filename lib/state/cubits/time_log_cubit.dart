import 'package:bloc_practice/state/models/time_log_model/time_log.dart';
import 'package:bloc_practice/state/models/time_log_repository/i_time_log_repository.dart';
import 'package:bloc_practice/state/substates/time_log_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeLogCubit extends Cubit<TimeLogState> implements ITimeLogRepository {
  TimeLogCubit() : super(TimeLogState.init());

  @override
  Future<void> deleteTimeLog(int id) {
    // TODO: implement deleteTimeLog
    throw UnimplementedError();
  }

  @override
  Future<List<TimeLog>?> getTimeLogs(int id) {
    // TODO: implement getTimeLogs
    throw UnimplementedError();
  }

  @override
  Future<void> saveTimeLog(TimeLog timeLog) {
    // TODO: implement saveTimeLog
    throw UnimplementedError();
  }
}
