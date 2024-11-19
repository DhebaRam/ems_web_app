import 'package:ems_app/bloc/ems_bloc.dart';
import 'package:ems_app/common/base_components/base_assets.dart';
import 'package:ems_app/common/base_components/base_colors.dart';
import 'package:ems_app/common/base_components/base_text.dart';
import 'package:ems_app/ui/screen/add_emp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/ems_event.dart';
import '../../bloc/ems_state.dart';
import '../../common/app_database/employee_model.dart';
import '../../common/base_components/base_app_bar.dart';
import '../../common/base_components/strings_class.dart';
import '../../common/utils/responsive.dart';
import '../../common/utils/utils_function.dart';
import '../widget/no_record_found_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: const BaseAppBar(
            centerTitle: false,
            backgroundColor: BaseColors.primaryColor,
            title: BaseText(
              value: Strings.employeeList,
              color: BaseColors.whiteColor,
              fontSize: 18,
            ),
          ),
          body: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
            if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeLoaded) {
              if (state.currentEmployees.isEmpty &&
                  state.previousEmployees.isEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildSizeHeight(mediaQueryHeight(context, 0.2)),
                    const Center(child: NoDataFoundWidget())
                  ],
                );
              }
              return Column(
                children: [
                  if (state.currentEmployees.isNotEmpty)
                    const ListTile(
                        tileColor: BaseColors.headerColor,
                        title: BaseText(
                            value: "Current employees",
                            fontWeight: FontWeight.w600,
                            color: BaseColors.primaryColor,
                            fontSize: 17)),
                  if (state.currentEmployees.isNotEmpty)
                    Expanded(
                        child: _buildEmployeeList(
                            context, state.currentEmployees,
                            current: true)),
                  if (state.previousEmployees.isNotEmpty)
                    const ListTile(
                        tileColor: BaseColors.headerColor,
                        title: BaseText(
                            value: "Previous employees",
                            fontWeight: FontWeight.w600,
                            color: BaseColors.primaryColor,
                            fontSize: 17)),
                  if (state.previousEmployees.isNotEmpty)
                    Expanded(
                        child: _buildEmployeeList(
                            context, state.previousEmployees)),
                  _buildSwipeHint(),
                ],
              );
            } else if (state is EmployeeError) {
              return Center(
                  child: BaseText(value: 'Unknown state ${state.message}'));
            } else {
              return Container();
            }
          }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: BaseColors.primaryColor,
            tooltip: 'Add Employee',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddEmpPage(
                          addEmpPage: true,
                        )),
              );
            },
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ));
  }

  Widget _buildSwipeHint() {
    return Container(
      color: BaseColors.headerColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: BaseText(
            value: 'Swipe left to delete',
            fontWeight: FontWeight.w400,
            color: BaseColors.secondTextColor,
            fontSize: 17),
      ),
    );
  }

  _buildEmployeeList(BuildContext context, List<Employee> employees,
      {bool current = false}) {
    final employeeBloc = context.read<EmployeeBloc>();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return Dismissible(
            key: ValueKey(employee.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(BaseAssets.deleteIcon, height: !Responsive.isLargeMobile(context)
                  ? 50
                  : mediaQueryWidth(context, 0.08),),
            ),
            onDismissed: (direction) {
              WidgetsBinding.instance.addPostFrameCallback((callback) async {
                final deleteData = employee;

                employeeBloc.add(DeleteEmployee(employee.id!));
                // Show snackbar with undo option
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: BaseColors.textColor,
                    content: const BaseText(
                      value: 'Employee data has been deleted',
                      fontWeight: FontWeight.w500,
                      color: BaseColors.whiteColor,
                      fontSize: 17,
                    ),
                    action: SnackBarAction(
                      textColor: BaseColors.primaryColor,
                      label: 'Undo',
                      onPressed: () {
                        final employee = Employee(
                          id: deleteData.id,
                          name: deleteData.name,
                          role: deleteData.role,
                          startDate: deleteData.startDate,
                          endDate: deleteData.endDate,
                        );
                        employeeBloc.add(AddEmployee(employee));
                      },
                    ),
                  ),
                );
              });
            },
            child: ListTile(
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey, // Border color
                  width: 0.2, // Border thickness
                ),
              ),
              title: BaseText(
                value: employee.name,
                fontWeight: FontWeight.w600,
                color: BaseColors.textColor,
                fontSize: 18,
                height: 2,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BaseText(
                    value: employee.role,
                    fontWeight: FontWeight.w400,
                    color: BaseColors.secondTextColor,
                    fontSize: 17,
                    height: 2,
                  ),
                  BaseText(
                    value: current
                        ? 'From ${employee.startDate.toString()}'
                        : '${employee.startDate.toString()} - ${employee.endDate.toString()}',
                    fontWeight: FontWeight.w400,
                    color: BaseColors.secondTextColor,
                    fontSize: 16,
                    height: 2,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEmpPage(employee: employee)),
                );
              },
            ),
          );
        });
  }
}
