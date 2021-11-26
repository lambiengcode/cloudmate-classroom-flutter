import 'dart:convert';

class HistoryQuizModel {
  final String id;
  final String title;
  HistoryQuizModel({
    required this.id,
    required this.title,
  });

  HistoryQuizModel copyWith({
    String? id,
    String? title,
  }) {
    return HistoryQuizModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory HistoryQuizModel.fromMap(Map<String, dynamic> map) {
    return HistoryQuizModel(
      id: map['id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryQuizModel.fromJson(String source) => HistoryQuizModel.fromMap(json.decode(source));

  @override
  String toString() => 'HistoryQuizModel(id: $id, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HistoryQuizModel &&
      other.id == id &&
      other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
