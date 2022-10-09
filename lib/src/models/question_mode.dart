import 'dart:convert';

import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/models/question_type_enum.dart';
import 'package:flutter/foundation.dart';

class QuestionModel {
  final String id;
  final String question;
  final List<String> answers;
  final List<int> corrects;
  final int duration;
  final String examId;
  final int score;
  final String? banner;
  final String? audio;
  final QuestionType type;
  QuestionModel({
    required this.id,
    required this.question,
    required this.answers,
    required this.corrects,
    required this.duration,
    required this.examId,
    required this.score,
    required this.banner,
    required this.type,
    required this.audio,
  });

  QuestionModel copyWith({
    String? id,
    String? question,
    List<String>? answers,
    List<int>? corrects,
    int? duration,
    String? examId,
    int? score,
    String? banner,
    String? audio,
    QuestionType? type,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      corrects: corrects ?? this.corrects,
      duration: duration ?? this.duration,
      examId: examId ?? this.examId,
      score: score ?? this.score,
      banner: banner ?? this.banner,
      type: type ?? this.type,
      audio: audio ?? this.audio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answers': answers,
      'correct': corrects,
      'duration': duration,
      'score': score,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    List<String> answers = List<String>.from(map['answers']);
    return QuestionModel(
      id: map['_id'],
      question: map['question'],
      answers: answers,
      corrects: map['correct'] == null
          ? []
          : (map['correct'] as List)
              .map((e) => int.parse(e.toString()))
              .toList(),
      duration: map['duration'],
      examId: map['idSetOfQuestions'] ?? '',
      score: map['score'] ?? 10,
      banner: map['banner'] == null || map['banner'].toString().isEmpty
          ? null
          : (Application.imageUrl + map['banner']['path']),
      audio: map['audio'] == null || map['audio'].toString().isEmpty
          ? null
          : (Application.imageUrl + map['audio']['path']),
      type: fromTypeNumber(type: map['typeQuestion'] ?? 2),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuestionModel(id: $id, question: $question, answers: $answers, duration: $duration, examId: $examId)';
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
