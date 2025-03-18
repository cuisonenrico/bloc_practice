import 'package:bloc_practice/state/models/employee_model/employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_state.freezed.dart';
part 'employee_state.g.dart';

@freezed
class EmployeeState with _$EmployeeState {
  factory EmployeeState({
    @Default([]) List<Employee> employeeList,
    @Default(null) Employee? selectedEmployee,
  }) = _EmployeeState;

  factory EmployeeState.fromJson(Map<String, dynamic> json) => _$EmployeeStateFromJson(json);

  factory EmployeeState.init() => EmployeeState(selectedEmployee: Employee.init());
}
