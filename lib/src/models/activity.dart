import 'dart:convert';

class Activity {
  final String id;
  String title;
  DateTime time;
  Activity({
    required this.id,
    required this.title,
    required this.time,
  });

  Activity copyWith({
    String? id,
    String? title,
    DateTime? time,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'],
      title: map['title'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source));

  @override
  String toString() => 'Activity(id: $id, title: $title, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity &&
        other.id == id &&
        other.title == title &&
        other.time == time;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ time.hashCode;
}
