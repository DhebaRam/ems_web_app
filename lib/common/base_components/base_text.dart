import 'package:ems_app/common/base_components/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/utils_function.dart';

class BaseText extends StatelessWidget {
  final String value;
  final String? fontFamily;
  final double fontSize;
  final double?
      height,
      topMargin,
      bottomMargin,
      leftMargin,
      rightMargin,
      letterSpacing,
      onTapTopPadding,
      onTapBottomPadding,
      onTapLeftPadding,
      onTapRightPadding;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final int? maxLines;
  final bool? enableHapticFeedback, hideKeyboard, underline;
  final void Function()? onTap;
  final TextOverflow? overflow;

  const BaseText({
    super.key,
    required this.value,
    this.fontSize = 18,
    this.color,
    this.fontFamily,
    this.fontWeight,
    this.fontStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.topMargin,
    this.bottomMargin,
    this.leftMargin,
    this.rightMargin,
    this.height,
    this.letterSpacing,
    this.onTap,
    this.onTapTopPadding,
    this.onTapBottomPadding,
    this.onTapLeftPadding,
    this.onTapRightPadding,
    this.enableHapticFeedback,
    this.hideKeyboard,
    this.underline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: topMargin ?? 0,
          bottom: bottomMargin ?? 0,
          right: rightMargin ?? 0,
          left: leftMargin ?? 0),
      child: GestureDetector(
        onTap: onTap != null
            ? () {
                if (enableHapticFeedback ?? true) {
                  triggerHapticFeedback();
                }
                if (hideKeyboard ?? true) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
                if (onTap != null) {
                  onTap!();
                }
              }
            : null,
        child: Padding(
          padding: EdgeInsets.only(
              top: onTapTopPadding ?? 0,
              bottom: onTapBottomPadding ?? 0,
              right: onTapRightPadding ?? 0,
              left: onTapLeftPadding ?? 0),
          child: Text(
            value,
            textAlign: textAlign ?? TextAlign.start,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
              fontSize: fontSize.sp,
              height: height ,
              decoration:
                  (underline ?? false) ? TextDecoration.underline : null,
              color: color ?? BaseColors.textColor,
              fontFamily: fontFamily ?? 'Roboto',
              fontWeight: fontWeight ?? FontWeight.w500,
              fontStyle: fontStyle,
              letterSpacing: letterSpacing,
            ),
          ),
        ),
      ),
    );
  }
}
