import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:cloudmate/src/models/user.dart';

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

class FinalStatisticModel {
  final int totalScore;
  final List<UserModel> users;
  FinalStatisticModel({
    required this.totalScore,
    required this.users,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalScore': totalScore,
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory FinalStatisticModel.fromMap(Map<String, dynamic> map) {
    return FinalStatisticModel(
      totalScore: map['class']['score'],
      users: List<UserModel>.from(
        map['member'].map(
          (x) => UserModel.fromStatistic(
            x['user'],
            score: x['score'],
          ),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FinalStatisticModel.fromJson(String  source) =>
      FinalStatisticModel.fromMap(json.decode(source));

  @override
  String toString() => 'FinalStatisticModel(totalScore: $totalScore, users: $users)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FinalStatisticModel &&
        other.totalScore == totalScore &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode => totalScore.hashCode ^ users.hashCode;
}
