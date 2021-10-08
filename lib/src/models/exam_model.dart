import 'dart:convert';

class ExamModel {
  final String id;
  final String name;
  final String description;
  final int usedTimes;
  final String classBy;
  final String createBy;
  ExamModel({
    required this.id,
    required this.name,
    required this.description,
    required this.usedTimes,
    required this.classBy,
    required this.createBy,
  });

  ExamModel copyWith({
    String? id,
    String? name,
    String? description,
    int? usedTimes,
    String? classBy,
    String? createBy,
  }) {
    return ExamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      usedTimes: usedTimes ?? this.usedTimes,
      classBy: classBy ?? this.classBy,
      createBy: createBy ?? this.createBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'usedTimes': usedTimes,
      'classBy': classBy,
      'createBy': createBy,
    };
  }

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      usedTimes: map['usedTimes'],
      classBy: map['classBy'],
      createBy: map['createBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamModel.fromJson(String source) =>
      ExamModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExamModel(id: $id, name: $name, description: $description, usedTimes: $usedTimes, classBy: $classBy, createBy: $createBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.usedTimes == usedTimes &&
        other.classBy == classBy &&
        other.createBy == createBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        usedTimes.hashCode ^
        classBy.hashCode ^
        createBy.hashCode;
  }
}
