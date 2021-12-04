import 'dart:convert';

class HistoryQuizModel {
  final String id;
  final String title;
  final int score;
  final bool isShow;
  final DateTime createdAt;
  HistoryQuizModel({
    required this.id,
    required this.title,
    required this.score,
    required this.isShow,
    required this.createdAt,
  });

  HistoryQuizModel copyWith({
    String? id,
    String? title,
    int? score,
    bool? isShow,
    DateTime? createdAt,
  }) {
    return HistoryQuizModel(
      id: id ?? this.id,
      title: title ?? this.title,
      score: score ?? this.score,
      isShow: isShow ?? this.isShow,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'score': score,
      'isShow': isShow,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory HistoryQuizModel.fromMap(Map<String, dynamic> map) {
    return HistoryQuizModel(
      id: map['_id'],
      title: map['title'],
      score: map['score'],
      isShow: map['isShow'],
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryQuizModel.fromJson(String source) => HistoryQuizModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryQuizModel(id: $id, title: $title, score: $score, isShow: $isShow, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HistoryQuizModel &&
      other.id == id &&
      other.title == title &&
      other.score == score &&
      other.isShow == isShow &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      score.hashCode ^
      isShow.hashCode ^
      createdAt.hashCode;
  }
}
