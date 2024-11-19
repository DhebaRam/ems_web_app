import 'package:ems_app/common/base_components/base_colors.dart';
import 'package:ems_app/common/base_components/base_text.dart';
import 'package:flutter/material.dart';

class EmployeeListWidget extends StatelessWidget {
  final List<String> empList;

  const EmployeeListWidget({super.key, required this.empList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: empList.length,
        itemBuilder: (context, index) {
          return Row(children: [
            Column(
              children: [
                BaseText(
                    value: empList[index],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: BaseColors.textColor)
              ],
            )
          ]);
        });
  }
}
