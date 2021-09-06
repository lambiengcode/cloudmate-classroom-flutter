import 'dart:convert';

class ScheduleDeadline {
  final String id;
  String name;
  DateTime deadline;
  String fileName;
  ScheduleDeadline({
    required this.id,
    required this.name,
    required this.deadline,
    required this.fileName,
  });

  ScheduleDeadline copyWith({
    String? id,
    String? name,
    DateTime? deadline,
    String? fileName,
  }) {
    return ScheduleDeadline(
      id: id ?? this.id,
      name: name ?? this.name,
      deadline: deadline ?? this.deadline,
      fileName: fileName ?? this.fileName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'deadline': deadline.millisecondsSinceEpoch,
      'fileName': fileName,
    };
  }

  factory ScheduleDeadline.fromMap(Map<String, dynamic> map) {
    return ScheduleDeadline(
      id: map['id'],
      name: map['name'],
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline']),
      fileName: map['fileName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleDeadline.fromJson(String source) =>
      ScheduleDeadline.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScheduleDeadline(id: $id, name: $name, deadline: $deadline, fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScheduleDeadline &&
        other.id == id &&
        other.name == name &&
        other.deadline == deadline &&
        other.fileName == fileName;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ deadline.hashCode ^ fileName.hashCode;
  }
}
