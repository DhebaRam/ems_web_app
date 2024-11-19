import '../common/app_database/employee_model.dart';

abstract class EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;

  EmployeeLoaded({required this.currentEmployees, required this.previousEmployees});
}

class EmployeeError extends EmployeeState {
  final String message;

  EmployeeError(this.message);
}
