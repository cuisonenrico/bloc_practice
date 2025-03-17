import 'package:async_redux/async_redux.dart';
import 'package:bloc_practice/utilities/enums/error_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  factory AppState({
    // Counter
    @Default(0) int counter,
    @Default('None') String text,
    @Default(ErrorCodes.STAND_BY) ErrorCodes errorCode,
    // Wait
    @Default(Wait.empty) @JsonKey(name: 'wait', includeFromJson: false) Wait wait,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  factory AppState.init() => AppState(wait: Wait());
}

abstract class StateSerializer<St> {
  Map<String, dynamic> encode(St state);

  St decode(Map<String, dynamic> data);
}

class AppStateSerializer extends StateSerializer<AppState> {
  @override
  AppState decode(Map<String, dynamic> data) => AppState.fromJson(data);

  @override
  Map<String, dynamic> encode(AppState state) => state.toJson();
}
