import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentFirestoreModel {
  final String createdBy;
  final String fileName;
  final Timestamp createdAt;
  final String urlToFile;
  final String roadMapContentId;
  AssignmentFirestoreModel({
    required this.createdBy,
    required this.fileName,
    required this.createdAt,
    required this.urlToFile,
    required this.roadMapContentId,
  });

  AssignmentFirestoreModel copyWith({
    String? createdBy,
    String? fileName,
    Timestamp? createdAt,
    String? urlToFile,
    String? roadMapContentId,
  }) {
    return AssignmentFirestoreModel(
      createdBy: createdBy ?? this.createdBy,
      fileName: fileName ?? this.fileName,
      createdAt: createdAt ?? this.createdAt,
      urlToFile: urlToFile ?? this.urlToFile,
      roadMapContentId: roadMapContentId ?? this.roadMapContentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdBy': createdBy,
      'fileName': fileName,
      'createdAt': createdAt,
      'urlToFile': urlToFile,
      'roadMapContentId': roadMapContentId,
    };
  }

  factory AssignmentFirestoreModel.fromMap(dynamic map) {
    return AssignmentFirestoreModel(
      createdBy: map['createdBy'] ?? '',
      fileName: map['fileName'] ?? '',
      createdAt: map['createdAt'],
      urlToFile: map['urlToFile'] ?? '',
      roadMapContentId: map['roadMapContentId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignmentFirestoreModel.fromJson(String source) =>
      AssignmentFirestoreModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AssignmentFirestoreModel(createdBy: $createdBy, fileName: $fileName, createdAt: $createdAt, urlToFile: $urlToFile, roadMapContentId: $roadMapContentId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignmentFirestoreModel &&
        other.createdBy == createdBy &&
        other.fileName == fileName &&
        other.createdAt == createdAt &&
        other.urlToFile == urlToFile &&
        other.roadMapContentId == roadMapContentId;
  }

  @override
  int get hashCode {
    return createdBy.hashCode ^
        fileName.hashCode ^
        createdAt.hashCode ^
        urlToFile.hashCode ^
        roadMapContentId.hashCode;
  }
}
