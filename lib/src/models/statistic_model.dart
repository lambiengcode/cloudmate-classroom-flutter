import 'dart:convert';

import 'package:flutter/foundation.dart';

class StatisticModel {
  final List<String> answers;
  final List<int> chooses;
  StatisticModel({
    required this.answers,
    required this.chooses,
  });
  

  StatisticModel copyWith({
    List<String>? answers,
    List<int>? chooses,
  }) {
    return StatisticModel(
      answers: answers ?? this.answers,
      chooses: chooses ?? this.chooses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'answers': answers,
      'chooses': chooses,
    };
  }

  factory StatisticModel.fromMap(Map<String, dynamic> map) {
    return StatisticModel(
      answers: List<String>.from(map['answers']),
      chooses: List<int>.from(map['chooses']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticModel.fromJson(String source) => StatisticModel.fromMap(json.decode(source));

  @override
  String toString() => 'StatisticModel(answers: $answers, chooses: $chooses)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StatisticModel &&
      listEquals(other.answers, answers) &&
      listEquals(other.chooses, chooses);
  }

  @override
  int get hashCode => answers.hashCode ^ chooses.hashCode;
}
