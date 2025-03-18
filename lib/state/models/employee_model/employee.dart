import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
class Employee with _$Employee {
  @HiveType(typeId: 1) // Hive adapter type ID

  factory Employee({
    @HiveField(0) int? id,
    @HiveField(1) String? firstName,
    @HiveField(2) String? lastName,
    @HiveField(3) DateTime? birthDate,
    @HiveField(4) double? hourlyRate,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

  factory Employee.init() => Employee(
        firstName: '',
        lastName: '',
        birthDate: DateTime.now(),
        hourlyRate: 0,
      );
}
