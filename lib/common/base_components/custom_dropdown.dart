import 'package:flutter/material.dart';

import '../../package/drop_downbutton2/src/dropdown_button2.dart';
import '../utils/utils_function.dart';
import 'base_colors.dart';
import 'base_text.dart';

class CustomDropDown extends StatefulWidget {
  final String? initialValue;
  final String hintText;
  final String? errorMsg;
  final List<Map<String, dynamic>>? listmapData;
  final bool isRequired;

  final bool isBackground;
  final Widget? iconRow;
  final Function(dynamic value) onChange;

  const CustomDropDown(
      {super.key,
        required this.initialValue,
        required this.hintText,
        required this.onChange,
        this.iconRow,
        this.isBackground = false,
        this.errorMsg,
        this.isRequired = true,
        this.listmapData});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 55,
            padding:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField2<dynamic>(
                isExpanded: true,
                isDense: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: BaseColors.borderColor),
                      borderRadius: getCustomBorderRadius(15)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: BaseColors.borderColor),
                      borderRadius: getCustomBorderRadius(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: BaseColors.borderColor),
                      borderRadius: getCustomBorderRadius(15)),
                ),
                value: widget.initialValue,
                hint: BaseText(
                    value: widget.hintText,
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontWeight: FontWeight.w800),
                iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(Icons.keyboard_arrow_down,
                        color: Theme.of(context).iconTheme.color),
                  ),
                ),
                validator: (value) {
                  // if (!isRequired) return null;
                  if (widget.errorMsg == null && value == null) {
                    return "This field is required.";
                  }
                  if (value == null) {
                    return widget.errorMsg;
                  }
                  return null;
                },
                dropdownStyleData: const DropdownStyleData(
                    offset: Offset(0, -10),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      // color: AppColors.bgColor
                    )),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                items: widget.listmapData!.map((data) {
                  return DropdownMenuItem(
                    value: data['value'],
                    child: BaseText(
                        value: data['name'].toString(),
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontWeight: FontWeight.w900),
                  );
                }).toList(),
                onChanged: widget.onChange,
              ),
            ),
          ),
        ),
      ],
    );
  }
}