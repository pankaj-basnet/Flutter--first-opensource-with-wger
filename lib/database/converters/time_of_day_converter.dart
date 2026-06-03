import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:realflutter/helpers/json.dart';

class TimeOfDayConverter extends TypeConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromSql(String fromDb) {
    return stringToTimeNull(fromDb)!;
  }

  @override
  String toSql(TimeOfDay value) {
    return timeToString(value)!;
  }
}
