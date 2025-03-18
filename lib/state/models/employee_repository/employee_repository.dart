import 'package:bloc_practice/state/models/employee_model/employee.dart';
import 'package:bloc_practice/state/models/employee_repository/i_employee_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IEmployeeRepository)
class EmployeeRepository implements IEmployeeRepository {
  final Box<Employee> _employeeBox;

  EmployeeRepository(this._employeeBox);

  @override
  Future<void> saveEmployee(Employee employee) async {
    try {
      await _employeeBox.put(employee.id, employee);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Future<List<Employee>?> getEmployees() async => _employeeBox.values.toList();

  @override
  Future<void> deleteEmployee(int id) async {
    if (_employeeBox.containsKey(id)) await _employeeBox.delete(id);
    return;
  }
}
