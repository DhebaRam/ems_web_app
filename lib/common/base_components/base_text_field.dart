import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_colors.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController? controller, secondController;
  final bool? obscureText, readOnly, autofocus, underLine;
  final bool isRequired,
      isName,
      isEmail,
      isMobile,
      isPassword,
      isConfirmPassword;
  final double? topMargin,
      bottomMargin,
      rightMargin,
      leftMargin,
      hintTxtSize,
      fontSize;
  final String hintText, labelText;
  final Color? fillColor, txtColor, borderColor, hintTextColor;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;
  final String? errorText, initialValue, validationMessage, prefixText;
  final int? maxLine, maxLength;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? prefixStyle;
  final Widget? suffixIcon, prefixIcon, prefix;
  final double borderRadius;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final FloatingLabelBehavior floatingLabelBehavior;
  final OutlineInputBorder? errorBorder;

  const BaseTextField(
      {super.key,
      this.controller,
      this.secondController,
      this.obscureText,
      this.textAlign,
      this.textAlignVertical,
      required this.labelText,
      required this.hintText,
      this.textInputAction,
      this.textInputType,
      this.textInputFormatter,
      this.suffixIcon,
      this.prefixStyle,
      this.prefixIcon,
      this.prefix,
      this.errorText,
      this.prefixText,
      this.borderRadius = 4,
      this.fillColor,
      this.txtColor,
      this.borderColor,
      this.maxLine,
      this.contentPadding,
      this.hintTxtSize,
      this.fontSize,
      this.onTap,
      this.readOnly,
      this.hintTextColor,
      this.autofocus,
      this.textCapitalization,
      this.validator,
      this.maxLength,
      this.underLine = false,
      this.onChanged,
      this.focusNode,
      this.initialValue,
      this.validationMessage,
      this.topMargin,
      this.bottomMargin,
      this.rightMargin,
      this.leftMargin,
      this.errorBorder,
      this.isRequired = true,
      this.isEmail = false,
      this.isName = false,
      this.isMobile = false,
      this.isPassword = false,
      this.isConfirmPassword = false,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topMargin ?? 0,
        bottom: bottomMargin ?? 0,
        right: rightMargin ?? 0,
        left: leftMargin ?? 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Visibility(
          //   visible: labelText.isNotEmpty,
          //   child: BaseText(
          //     value: labelText,
          //     color: Colors.black,
          //     fontSize: 12,
          //   ),
          // ),
          // Visibility(
          //   visible: labelText.isNotEmpty,
          //   child: const SizedBox(height: 3),
          // ),
          TextFormField(
            controller: controller ?? TextEditingController(),
            obscureText: obscureText ?? false,
            obscuringCharacter: "*",
            maxLines: maxLine ?? 1,
            onTap: onTap,
            focusNode: focusNode,
            readOnly: readOnly ?? false,
            onTapAlwaysCalled: true,
            // ignorePointers: readOnly,
            textInputAction: textInputAction ?? TextInputAction.next,
            keyboardType: textInputType,
            textAlign: textAlign ?? TextAlign.start,
            inputFormatters: textInputFormatter,
            textAlignVertical: textAlignVertical,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            autofocus: autofocus ?? false,
            // validator: validator,
            validator: (String? value) {
              if (!isRequired) {
                return null;
              }
              if (value!.isEmpty) {
                return '* Required';
              }
              if (value.isEmpty) {
                return '';
              } else {
                const namePattern =
                    r"^[a-zA-ZàáâäçèéêëìíîïñòóôöùúûüýÿÀÁÂÄÇÈÉÊËÌÍÎÏÑÒÓÔÖÙÚÛÜÝŸ' -]+$";

                const emailPattern =
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

                // r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                //       r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                //       r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                //       r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                //       r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                //       r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                //       r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

                const passwordPattern =
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

                String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                RegExp regexName = RegExp(namePattern);
                RegExp regexMobile = RegExp(mobilePattern);

                final regexEmail = RegExp(emailPattern);
                final regexPassword = RegExp(passwordPattern);

                if (isName && value.isNotEmpty) {
                  if (value.length < 2) {
                    return 'Name must be at least 2 characters'; // Minimum length message
                  } else if (value.length > 50) {
                    return 'Name must be 50 characters or less'; // Maximum length message
                  } else if (!regexName.hasMatch(value)) {
                    return 'Name can only contain letters, spaces, hyphens,\nand apostrophes'; // Invalid characters message
                  } else {
                    return null;
                  }
                } else if (isEmail && value.isNotEmpty) {
                  // Email maximum length check (RFC 5321 max length: 254 characters)
                  if (value.length > 254) {
                    return 'Email is too long (max 254 characters)';
                  }
                  if (isEmail &&
                      value.isNotEmpty &&
                      !regexEmail.hasMatch(value)) {
                    return validationMessage ?? 'Please Enter Valid Email';
                  } else {
                    return null;
                  }
                } else if (isPassword && value.isNotEmpty) {
                  if (isPassword && value.isNotEmpty && value.length < 6) {
                    return 'Password must be longer than 6 characters.';
                  } else if (isPassword &&
                      value.isNotEmpty &&
                      (!regexPassword.hasMatch(value))) {
                    return validationMessage ??
                        'Use upper, lower, number & special character.';
                  } else if (isPassword &&
                      isConfirmPassword &&
                      value.isNotEmpty &&
                      !regexPassword.hasMatch(value) &&
                      (controller?.text.trim().toString() !=
                          secondController?.text.trim().toString())) {
                    return 'Passwords do not match';
                  } else {
                    return null;
                  }
                } else if (isMobile && value.isNotEmpty) {
                  if (isMobile &&
                      value.isNotEmpty &&
                      !regexMobile.hasMatch(value)) {
                    return 'Please enter valid mobile number';
                  } else if (isMobile &&
                      value.isNotEmpty &&
                      value.length < 10) {
                    return 'Password Must be more than 8 characters';
                  } else {
                    return null;
                  }
                } else {
                  null;
                }
              }
              return null;
            },
            onChanged: onChanged,
            cursorColor: BaseColors.secondaryColor,
            maxLength: maxLength ?? 200,
            style: TextStyle(
                color:
                    txtColor ?? Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: fontSize ?? 15,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              floatingLabelBehavior: floatingLabelBehavior,
              contentPadding: contentPadding ??
                  const EdgeInsets.only(
                    top: 18,
                    bottom: 18,
                    left: 20,
                    right: 20.0,
                  ),
              isDense: true,
              hintMaxLines: 3,
              labelText: labelText,
              hintText: hintText,
              errorText: errorText,
              counter: const SizedBox.shrink(),
              counterStyle:
                  const TextStyle(fontSize: 0, color: Colors.transparent),
              labelStyle: TextStyle(
                  color: hintTextColor ?? BaseColors.hintColor,
                  fontSize: hintTxtSize ?? 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
              counterText: "",
              semanticCounterText: "",
              suffixIconConstraints: const BoxConstraints(maxHeight: 60),
              prefixIconConstraints: const BoxConstraints(maxHeight: 60),
              alignLabelWithHint: true,
              hintStyle: TextStyle(
                  color: hintTextColor ?? BaseColors.hintColor,
                  fontSize: hintTxtSize ?? 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
              errorStyle: TextStyle(
                  color: BaseColors.redColor,
                  fontSize: hintTxtSize ?? 14,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Roboto'),
              filled: true,
              fillColor: fillColor ?? Colors.transparent,
              prefix: prefix,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? BaseColors.borderColor, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? BaseColors.borderColor, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffDDDDDD), width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffDDDDDD), width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              errorBorder: errorBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                  ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? const Color(0xffDDDDDD), width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
