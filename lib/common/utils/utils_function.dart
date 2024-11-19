import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


triggerHapticFeedback() {
  if (Platform.isAndroid) {
    HapticFeedback.vibrate();
  } else {
    HapticFeedback.lightImpact();
  }
}

var currentBackPressTime;
Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: 'Press back again to exit');
    return Future.value(false);
  }
  currentBackPressTime = null;
  return Future.value(true);
}

SizedBox buildSizeHeight(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox buildSizeWidth(double width) {
  return SizedBox(
    width: width,
  );
}

double mediaQueryWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * width;
}

double mediaQueryHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * height;
}

BorderRadius getCustomBorderRadius(double radius) {
  return BorderRadius.circular(radius);
}

/////////////////////////////
String inFormat = "yyyy-MM-dd HH:mm:ss";
// // ignore: non_constant_identifier_names
String isoFormat = "yyyy-MM-ddThh:mm:ss";
String outFormat = "dd MMM, yyyy";
String inFormat1 = "yyyy-MM-dd";
String outFormat1 = "dd-MM-yyyy";
String outFormat2 = "dd/MM/yyyy";
String outFormat3 = "dd MMM";
String outFormat4 = "dd MMM yyyy, HH:mm a";
String outFormat5 = "dd MMM yyyy, hh:mm a";
String outFormat6 = "dd MMM yyyy, h:mm a";
// ignore: non_constant_identifier_names
String F12_Hours = "h:mm a";
String outFormat7 = "dd MMM yyyy • h:mm a";
String time = "dd MMM, h:mm a";

formatDateFromString(String? date, {String? input, String? output}) {
  if((date ?? "").isEmpty) return "";
  var inputDate = DateFormat(input ?? inFormat).parse(date.toString(), true).toLocal();
  var outputDate = DateFormat(output ?? outFormat).format(inputDate);
  return outputDate.toString();
}

String formatDateFromStringOutput(String dateStr) {
  try {
    // Specify the exact format for the date string (ISO 8601 format)
    final DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    final DateTime parsedDate = dateFormat.parse(dateStr);
    final DateFormat outputFormat = DateFormat('MMM dd, yyyy'); // Adjust the format as needed
    return outputFormat.format(parsedDate);
  } catch (e) {
    // Handle parsing error, and you could return an error message if needed
    print('Error parsing date: $e');
    return 'Invalid Date';
  }
}
