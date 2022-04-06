import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat _onlyDateFormatter = DateFormat('dd/MM/yyyy');
DateFormat _fullDateFormatter = DateFormat('dd/MM/yyyy HH:mm');
DateFormat _onlyTimeFormatter = DateFormat('HH:mm');

late MaterialLocalizations _localizations;

String dateFormatterToString(Timestamp dateWithoutTime) {
  return _onlyDateFormatter.format(dateWithoutTime.toDate());
}

String dateTimeFormatterToString(DateTime dateWithoutTime) {
  return _onlyDateFormatter.format(dateWithoutTime);
}

Timestamp dateFormatterFromString(String formattedString) {
  return Timestamp.fromDate(_onlyDateFormatter.parse(formattedString));
}

String dateAndTimeFormatterToString(Timestamp dateWithTime) {
  return _fullDateFormatter.format(dateWithTime.toDate());
}

Timestamp dateAndTimeFormatterFromString(String formattedString) {
  return Timestamp.fromDate(_fullDateFormatter.parse(formattedString));
}

Timestamp fullTimeFormatterFromString(String date, String time) {
  var _date = _fullDateFormatter.parse(date+ " " + time);

  
  return Timestamp.fromDate(_date);
}

String timeFormatterToString(Timestamp time) {
  // _localizations = DefaultMaterialLocalizations();
  // return _localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

  return _onlyTimeFormatter.format(time.toDate());
}

String timeOfDayFormatterToString(TimeOfDay time) {
   _localizations = DefaultMaterialLocalizations();
   return _localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

  
}

Timestamp timeFormatterFromString(String formattedString) {
  return Timestamp.fromDate(_onlyTimeFormatter.parse(formattedString));
}

/* extension IntExtension on int {
  ///[this] must be millisecondSinceEpoch
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this);

  String get toFormattedStringAsDateTime =>
      dateFormatterToString(this.toDateTime);

  TimeOfDay get toTimeOfDay => TimeOfDay.fromDateTime(this.toDateTime);

  String get toFormattedStringAsTimeOfDay =>
      timeFormatterToString(TimeOfDay.fromDateTime(this.toDateTime));
} */

/* extension DateTimeExtension on DateTime {
  int get toMillisecondEpochInt => this.millisecondsSinceEpoch;
  int toMap() => this.toMillisecondEpochInt;
}

extension TimeOfDayExt on TimeOfDay {
  int get toMillisecondInt {
    var date = DateTime(0, 0, 0, this.hour, this.minute);
    return date.millisecondsSinceEpoch;
  }
}
 */