import 'dart:convert';
import 'package:cloudmate/src/models/road_map_content_type.dart';

class RoadMapContentModel {
  final String id;
  final String roadMapContentId;
  final String name;
  final String description;
  final RoadMapContentType type;
  final DateTime startTime;
  final DateTime endTime;
  List<String>? fileExtensions;
  RoadMapContentModel({
    required this.id,
    required this.roadMapContentId,
    required this.name,
    required this.description,
    required this.type,
    required this.startTime,
    required this.endTime,
    this.fileExtensions,
  });

  RoadMapContentModel copyWith({
    String? id,
    String? roadMapContentId,
    String? name,
    String? description,
    RoadMapContentType? type,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return RoadMapContentModel(
      id: id ?? this.id,
      roadMapContentId: roadMapContentId ?? this.roadMapContentId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roadMapContentId': roadMapContentId,
      'name': name,
      'description': description,
      'type': type.toIntValue,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
    };
  }

  factory RoadMapContentModel.fromMap(Map<String, dynamic> map) {
    return RoadMapContentModel(
      id: map['rmc']['_id'] ?? '',
      roadMapContentId: map['rmc']['_id'] ?? '',
      name: map['rmc']['name'],
      description: map['rmc']?['description'],
      type: fromIntValue(map['type']),
      startTime: DateTime.parse(map['rmc']?['startTime']),
      endTime: DateTime.parse(map['rmc']?['endTime']),
      fileExtensions: map['rmc']?['fileExtensions'] == null
          ? null
          : (map['rmc']!['fileExtensions'] as List).cast(),
    );
  }

  factory RoadMapContentModel.fromMapPost(Map<String, dynamic> mapA) {
    Map<String, dynamic> map = mapA['rmcAssignment'] ?? mapA['rmcAttendance'];

    return RoadMapContentModel(
      id: map['_id'],
      roadMapContentId: map['_id'],
      name: map['name'],
      description: map['description'],
      type: mapA['rmcAssignment'] != null
          ? RoadMapContentType.assignment
          : RoadMapContentType.attendance,
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      fileExtensions: map['fileExtensions'] == null ? null : (map['fileExtensions'] as List).cast(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoadMapContentModel.fromJson(String source) =>
      RoadMapContentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoadMapContentModel(id: $id, roadMapContentId: $roadMapContentId, name: $name, description: $description, type: $type, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoadMapContentModel &&
        other.id == id &&
        other.roadMapContentId == roadMapContentId &&
        other.name == name &&
        other.description == description &&
        other.type == type &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roadMapContentId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        type.hashCode ^
        startTime.hashCode ^
        endTime.hashCode;
  }
}
