import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../common/app_database/employee_database.dart';
import '../common/app_database/employee_model.dart';
import 'ems_event.dart';
import 'ems_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final DatabaseHelper database;

  EmployeeBloc(this.database) : super(EmployeeLoading()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
  }

  void _onLoadEmployees(LoadEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      // Fetch current and previous employees
      final employees = await database.fetchEmployees();

      // Filter employees into 'current' and 'previous' categories
      final currentEmployees = employees
          .where((e) => e['end_date'] == null || e['end_date']!.isEmpty)
          .map((e) => Employee.fromMap(e))
          .toList();

      final previousEmployees = employees
          .where((e) => e['end_date'] != null && e['end_date']!.isNotEmpty)
          .map((e) => Employee.fromMap(e))
          .toList();

      emit(EmployeeLoaded(
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ));
    } catch (e) {
      log('Failed to load employees. ---- > ${e.toString()}');
      emit(EmployeeError('Failed to load employees.'));
    }
  }

  void _onAddEmployee(AddEmployee event, Emitter<EmployeeState> emit) async {
    try {
      final newEmployee = event.employee.toMap();
      await database.addEmployee(newEmployee);
      add(LoadEmployees()); // Refresh employee list
    } catch (e) {
      emit(EmployeeError('Failed to add employee.'));
    }
  }

  void _onUpdateEmployee(UpdateEmployee event, Emitter<EmployeeState> emit) async {
    try {
      final updatedEmployee = event.employee.toMap();
      await database.updateEmployee(updatedEmployee, event.employee.id!);
      add(LoadEmployees()); // Refresh employee list
    } catch (e) {
      emit(EmployeeError('Failed to update employee.'));
    }
  }

  void _onDeleteEmployee(DeleteEmployee event, Emitter<EmployeeState> emit) async {
    try {
      await database.deleteEmployee(event.id);
      add(LoadEmployees()); // Refresh employee list
    } catch (e) {
      emit(EmployeeError('Failed to delete employee.'));
    }
  }
}
