import 'dart:convert';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['_id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));

  @override
  String toString() => 'NotificationModel(id: $id, title: $title, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NotificationModel &&
      other.id == id &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
