import 'dart:convert';

class RoadMapContentModel {
  final String id;
  RoadMapContentModel({
    required this.id,
  });

  RoadMapContentModel copyWith({
    String? id,
  }) {
    return RoadMapContentModel(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory RoadMapContentModel.fromMap(Map<String, dynamic> map) {
    return RoadMapContentModel(
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoadMapContentModel.fromJson(String source) => RoadMapContentModel.fromMap(json.decode(source));

  @override
  String toString() => 'RoadMapContentModel(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RoadMapContentModel &&
      other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
