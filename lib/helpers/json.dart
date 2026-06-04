// lib/helpers/json.dart
// Utility functions for JSON/date/time parsing — used throughout the project.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

num stringToNum(String? e) {
  return e == null ? 0 : num.parse(e);
}

num? stringToNumNull(String? e) {
  return e == null ? null : num.parse(e);
}

num stringOrIntToNum(dynamic e) {
  if (e is int) return e.toDouble();
  return num.tryParse(e.toString()) ?? 0;
}

String? numToString(num? e) {
  if (e == null) return null;
  return e.toString();
}

String? dateToYYYYMMDD(DateTime? dateTime) {
  if (dateTime == null) return null;
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String dateToUtcIso8601(DateTime dateTime) {
  return dateTime.toUtc().toIso8601String();
}

DateTime utcIso8601ToLocalDate(String dateTime) {
  return DateTime.parse(dateTime).toLocal();
}

DateTime? utcIso8601ToLocalDateNull(String? dateTime) {
  if (dateTime == null) return null;
  return utcIso8601ToLocalDate(dateTime);
}

TimeOfDay stringToTime(String? time) {
  time ??= '00:00';
  return TimeOfDay.fromDateTime(DateTime.parse('2020-01-01 $time'));
}

TimeOfDay? stringToTimeNull(String? time) {
  if (time == null) return null;
  try {
    return TimeOfDay.fromDateTime(DateTime.parse('2020-01-01 $time'));
  } catch (_) {
    return null;
  }
}

String? timeToString(TimeOfDay? time) {
  if (time == null) return null;
  return const DefaultMaterialLocalizations().formatTimeOfDay(
    time,
    alwaysUse24HourFormat: true,
  );
}
