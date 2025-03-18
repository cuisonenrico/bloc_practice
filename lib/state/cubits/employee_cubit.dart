import 'package:bloc_practice/state/models/employee_model/employee.dart';
import 'package:bloc_practice/state/models/employee_repository/employee_repository.dart';
import 'package:bloc_practice/state/models/employee_repository/i_employee_repository.dart';
import 'package:bloc_practice/state/substates/employee_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class EmployeeCubit extends Cubit<EmployeeState> implements IEmployeeRepository {
  EmployeeCubit() : super(EmployeeState.init());

  @override
  Future<List<Employee>?> getEmployees() async {
    final box = await Hive.openBox<Employee>('Employees');

    // Loads all employees saved in DB
    final employees = await EmployeeRepository(box).getEmployees();
    if (kDebugMode) {
      print(employees);
    }
    if (employees == null) return null;

    // Store all employees in [DB] in [state]
    emit(state.copyWith(employeeList: employees));
    return employees;
  }

  @override
  Future<void> saveEmployee(Employee employee) async {
    try {
      final box = await Hive.openBox<Employee>('Employees');

      final id = box.length + 1;
      // Save employee in [DB]
      EmployeeRepository(box).saveEmployee(employee.copyWith(id: id));
      final employees = state.employeeList;

      // Store the employee in [state]
      emit(state.copyWith(employeeList: [...employees, employee]));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  @override
  Future<void> deleteEmployee(int id) async {
    try {
      final box = await Hive.openBox<Employee>('Employees');

      // Save employee in [DB]
      EmployeeRepository(box).deleteEmployee(id);

      await getEmployees();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void setFirstName(String firstName) =>
      emit(state.copyWith(selectedEmployee: state.selectedEmployee?.copyWith(firstName: firstName)));

  void setLastName(String lastName) =>
      emit(state.copyWith(selectedEmployee: state.selectedEmployee?.copyWith(lastName: lastName)));

  void setHourlyRate(double hourlyRate) =>
      emit(state.copyWith(selectedEmployee: state.selectedEmployee?.copyWith(hourlyRate: hourlyRate)));

  void setBirthDate(DateTime birthDate) {
    emit(state.copyWith(selectedEmployee: state.selectedEmployee?.copyWith(birthDate: birthDate)));
  }

  Future<void> deleteEmployeeFromList(Employee employee) async {
    /// This should refer to a unique key to be able to delete just one entry in the list.
    try {
      final box = await Hive.openBox<Employee>('Employees');

      final id = box.length + 1;
      // Save employee in [DB]
      EmployeeRepository(box).saveEmployee(employee.copyWith(id: id));
      final employees = state.employeeList;

      // Store the employee in [state]
      emit(state.copyWith(employeeList: [...employees, employee]));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    final employeeList = state.employeeList.where((e) => e != employee).toList();

    emit(state.copyWith(employeeList: employeeList));
  }
}
