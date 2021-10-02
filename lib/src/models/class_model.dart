import 'dart:convert';

import 'package:cloudmate/src/models/user.dart';

class ClassModel {
  final String id;
  final String name;
  final String topic;
  final String intro;
  final UserModel createdBy;
  ClassModel({
    required this.id,
    required this.name,
    required this.topic,
    required this.intro,
    required this.createdBy,
  });

  ClassModel copyWith({
    String? id,
    String? name,
    String? topic,
    String? intro,
    UserModel? createdBy,
  }) {
    return ClassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      topic: topic ?? this.topic,
      intro: intro ?? this.intro,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'topic': topic,
      'intro': intro,
      'createdBy': createdBy.toMap(),
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'],
      name: map['name'],
      topic: map['topic'],
      intro: map['intro'],
      createdBy: UserModel.fromMap(map['createdBy']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModel.fromJson(String source) => ClassModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassModel(id: $id, name: $name, topic: $topic, intro: $intro, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClassModel &&
      other.id == id &&
      other.name == name &&
      other.topic == topic &&
      other.intro == intro &&
      other.createdBy == createdBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      topic.hashCode ^
      intro.hashCode ^
      createdBy.hashCode;
  }
}
