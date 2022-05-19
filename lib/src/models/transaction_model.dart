import 'dart:convert';

import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/constants.dart';

class TransactionModel {
  final String id;
  final int status;
  final String content;
  final String amount;
  final ClassModel classModel;
  final UserModel sender;
  final UserModel receiver;
  final String systemContent;
  final DateTime createdAt;
  TransactionModel({
    required this.id,
    required this.status,
    required this.content,
    required this.amount,
    required this.classModel,
    required this.sender,
    required this.receiver,
    required this.systemContent,
    required this.createdAt,
  });

  TransactionModel copyWith({
    String? id,
    int? status,
    String? content,
    String? amount,
    ClassModel? classModel,
    UserModel? sender,
    UserModel? receiver,
    String? systemContent,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      status: status ?? this.status,
      content: content ?? this.content,
      amount: amount ?? this.amount,
      classModel: classModel ?? this.classModel,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      systemContent: systemContent ?? this.systemContent,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'content': content,
      'amount': amount,
      'classModel': classModel.toMap(),
      'sender': sender.toMap(),
      'receiver': receiver.toMap(),
      'systemContent': systemContent,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    UserModel adminUser = UserModel(
      id: '',
      displayName: 'ADMIN',
      image: Constants.urlImageDefault,
    );  
    return TransactionModel(
      id: map['_id'] ?? '',
      status: map['status']?.toInt() ?? 0,
      content: map['content'] ?? '',
      amount: map['amount'] ?? '',
      classModel: ClassModel.fromMap(map['class']),
      sender: map['sender'] == null ? adminUser : UserModel.fromMap(map['sender']),
      receiver: UserModel.fromMap(map['receiver']),
      systemContent: map['systemContent'] ?? '',
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(id: $id, status: $status, content: $content, amount: $amount, classModel: $classModel, sender: $sender, receiver: $receiver, systemContent: $systemContent, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.status == status &&
        other.content == content &&
        other.amount == amount &&
        other.classModel == classModel &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.systemContent == systemContent &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        content.hashCode ^
        amount.hashCode ^
        classModel.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        systemContent.hashCode ^
        createdAt.hashCode;
  }
}
