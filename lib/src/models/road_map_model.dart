import 'dart:convert';

class RoadMapModel {
  final String id;
  final String name;
  final String description;
  final int status;
  final String createBy;
  RoadMapModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.createBy,
  });

  RoadMapModel copyWith({
    String? id,
    String? name,
    String? description,
    int? status,
    String? createBy,
  }) {
    return RoadMapModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      createBy: createBy ?? this.createBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'createBy': createBy,
    };
  }

  factory RoadMapModel.fromMap(Map<String, dynamic> map) {
    return RoadMapModel(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      status: map['status'],
      createBy: map['createBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoadMapModel.fromJson(String source) =>
      RoadMapModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoadMapModel(id: $id, name: $name, description: $description, status: $status, createBy: $createBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoadMapModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.status == status &&
        other.createBy == createBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        status.hashCode ^
        createBy.hashCode;
  }
}
