import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingapp/providers/allPrkingProvide.dart';
import 'package:provider/provider.dart';

class DateFormCustom {
  String? dateTimePicked = '';
  String? timePicked = '';
  String finalDateValue = '';
  void dateformater() {
    var formatedated =
        "${DateFormat("yyyy-MM-dd").format(DateTime.parse("$dateTimePicked")).toString()}T$timePicked:00.000";

    finalDateValue = formatedated.toString();
  }

  void setdate(DateTime? date) {
    dateTimePicked = date!.toIso8601String();
  }

  void setTime(String hour, String minute) {
    timePicked =
        "${hour.length == 1 ? "0$hour" : hour}:${minute.length == 1 ? "0$minute" : minute}";
    dateformater();
  }

  Future selectDate(BuildContext context) async {
    return await showDatePicker(
            // currentDate: DateTime.now()

            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365 + 365)))
        .then((value) async {
      if (value != null) {
        setdate(value);
        await selectTime(context);
      }
    });
  }

  Future selectTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setTime(value.hour.toString(), value.minute.toString());
      }
    });
  }

  Future<String> getDateNow(
    BuildContext context,
  ) async {
   
    dateTimePicked = '';
    timePicked = '';
    finalDateValue = '';
    String val = "";
    await selectDate(context).then((value) {
      val = finalDateValue;
      log('in class Value = $val ');

    });
    return val;
  }
}