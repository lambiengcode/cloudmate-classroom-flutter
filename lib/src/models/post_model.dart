import 'dart:convert';

import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';

class PostModel {
  final String id;
  final ClassModel classModel;
  final RoadMapContentModel? roadMapContent;
  final DateTime createdAt;
  PostModel({
    required this.id,
    required this.classModel,
    required this.roadMapContent,
    required this.createdAt,
  });

  PostModel copyWith({
    String? id,
    ClassModel? classModel,
    RoadMapContentModel? roadMapContent,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      classModel: classModel ?? this.classModel,
      roadMapContent: roadMapContent ?? this.roadMapContent,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'classModel': classModel.toMap(),
      'roadMapContent': roadMapContent?.toMap(),
      'createdAt': createdAt.toString(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['_id'] ?? '',
      classModel: ClassModel.fromMap(map['class']),
      roadMapContent: RoadMapContentModel.fromMapPost(map['roadMapContent']),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, classModel: $classModel, roadMapContent: $roadMapContent, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.classModel == classModel &&
        other.roadMapContent == roadMapContent &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ classModel.hashCode ^ roadMapContent.hashCode ^ createdAt.hashCode;
  }
}
