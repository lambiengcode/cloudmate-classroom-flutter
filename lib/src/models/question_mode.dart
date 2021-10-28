import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuestionModel {
  final String id;
  final String question;
  final List<String> answers;
  final List<int> corrects;
  final int duration;
  final String examId;
  final int score;
  QuestionModel({
    required this.id,
    required this.question,
    required this.answers,
    required this.corrects,
    required this.duration,
    required this.examId,
    required this.score,
  });

  QuestionModel copyWith({
    String? id,
    String? question,
    List<String>? answers,
    List<int>? corrects,
    int? duration,
    String? examId,
    int? score,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      corrects: corrects ?? this.corrects,
      duration: duration ?? this.duration,
      examId: examId ?? this.examId,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answers': answers,
      'corrects': corrects,
      'duration': duration,
      'examId': examId,
      'score': score,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['_id'],
      question: map['question'],
      answers: List<String>.from(map['answers']),
      corrects: List<int>.from(map['correct']),
      duration: map['duration'],
      examId: map['examId'],
      score: map['score'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuestionModel(id: $id, question: $question, answers: $answers, corrects: $corrects, duration: $duration, examId: $examId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionModel &&
        other.id == id &&
        other.question == question &&
        listEquals(other.answers, answers) &&
        listEquals(other.corrects, corrects) &&
        other.duration == duration &&
        other.examId == examId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        answers.hashCode ^
        corrects.hashCode ^
        duration.hashCode ^
        examId.hashCode;
  }
}
