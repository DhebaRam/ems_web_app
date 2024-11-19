import 'package:ems_app/ui/screen/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sqflite/sqflite.dart';

import 'bloc/ems_bloc.dart';
import 'bloc/ems_event.dart';
import 'common/app_database/employee_database.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  // Initialize the database factory for web
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final EmployeeDatabase database;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeBloc(DatabaseHelper())..add(LoadEmployees()),
      child: GestureDetector(onTap: () {
        if (FocusManager.instance.primaryFocus!.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      }, child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'EMS App',
            theme: ThemeData(
                primarySwatch: Colors.indigo, canvasColor: Colors.transparent),
            //Our only screen/page we have
            home: const HomePage(),
          );
        },
      )),
    );
  }
}
