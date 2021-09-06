import 'dart:convert';

import 'package:flutter/foundation.dart';

class Attendance {
  final String id;
  List<String> attendances;
  int total;
  DateTime startTime;
  DateTime endTime;
  Attendance({
    required this.id,
    required this.attendances,
    required this.startTime,
    required this.endTime,
    required this.total,
  });

  Attendance copyWith({
    String? id,
    List<String>? attendances,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return Attendance(
      id: id ?? this.id,
      attendances: attendances ?? this.attendances,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      total: total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'attendances': attendances,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      attendances: List<String>.from(map['attendances']),
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attendance(id: $id, attendances: $attendances, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attendance &&
        other.id == id &&
        listEquals(other.attendances, attendances) &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        attendances.hashCode ^
        startTime.hashCode ^
        endTime.hashCode;
  }
}
