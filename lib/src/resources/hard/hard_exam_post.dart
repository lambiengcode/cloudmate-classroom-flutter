import 'dart:convert';

class Exam {
  final String id;
  String name;
  DateTime startTime;
  int duration;
  Exam({
    required this.id,
    required this.name,
    required this.startTime,
    required this.duration,
  });

  Exam copyWith({
    String? id,
    String? name,
    DateTime? startTime,
    int? duration,
  }) {
    return Exam(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startTime': startTime.millisecondsSinceEpoch,
      'duration': duration,
    };
  }

  factory Exam.fromMap(Map<String, dynamic> map) {
    return Exam(
      id: map['id'],
      name: map['name'],
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Exam.fromJson(String source) => Exam.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exam(id: $id, name: $name, startTime: $startTime, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exam &&
        other.id == id &&
        other.name == name &&
        other.startTime == startTime &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ startTime.hashCode ^ duration.hashCode;
  }
}
