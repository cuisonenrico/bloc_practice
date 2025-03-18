import 'package:bloc_practice/state/models/employee_model/employee.dart';

abstract class IEmployeeRepository {
  Future<void> saveEmployee(Employee employee);
  Future<List<Employee>?> getEmployees();
  Future<void> deleteEmployee(int id);
}
