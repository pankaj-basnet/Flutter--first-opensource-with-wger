import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

num stringToNum(String? e) {
  return e == null ? 0 : num.parse(e);
}

num? stringToNumNull(String? e) {
  return e == null ? null : num.parse(e);
}

num stringOrIntToNum(dynamic e) {
  if (e is int) {
    return e.toDouble();
  }
  return num.tryParse(e) ?? 0;
}

String? numToString(num? e) {
  if (e == null) {
    return null;
  }

  return e.toString();
}

/*
 * Converts a datetime to ISO8601 date format, but only the date.
 * Needed e.g. when the wger api only expects a date and no time information.
 */
String? dateToYYYYMMDD(DateTime? dateTime) {
  if (dateTime == null) {
    return null;
  }
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String dateToUtcIso8601(DateTime dateTime) {
  return dateTime.toUtc().toIso8601String();
}

DateTime utcIso8601ToLocalDate(String dateTime) {
  return DateTime.parse(dateTime).toLocal();
}

DateTime? utcIso8601ToLocalDateNull(String? dateTime) {
  if (dateTime == null) {
    return null;
  }

  return utcIso8601ToLocalDate(dateTime);
}

/*
 * Converts a time to a date object.
 * Needed e.g. when the wger api only sends a time but no date information.
 */
TimeOfDay stringToTime(String? time) {
  time ??= '00:00';
  return TimeOfDay.fromDateTime(DateTime.parse('2020-01-01 $time'));
}

TimeOfDay? stringToTimeNull(String? time) {
  if (time == null) {
    return null;
  }

  return TimeOfDay.fromDateTime(DateTime.parse('2020-01-01 $time'));
}

/*
 * Converts a datetime to time.
 */
String? timeToString(TimeOfDay? time) {
  if (time == null) {
    return null;
  }
  return const DefaultMaterialLocalizations().formatTimeOfDay(
    time,
    alwaysUse24HourFormat: true,
  );
}
