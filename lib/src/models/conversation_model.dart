import 'dart:convert';

import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/message_model.dart';

class ConversationModel {
  final String id;
  final int status;
  final String user;
  final ClassModel idClass;
  final DateTime createdAt;
  LatestMessage? latestMessage;
  ConversationModel({
    required this.id,
    required this.status,
    required this.user,
    required this.idClass,
    required this.createdAt,
    required this.latestMessage,
  });

  ConversationModel copyWith({
    String? id,
    int? status,
    String? user,
    ClassModel? idClass,
    DateTime? createdAt,
    LatestMessage? latestMessage,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      status: status ?? this.status,
      user: user ?? this.user,
      idClass: idClass ?? this.idClass,
      createdAt: createdAt ?? this.createdAt,
      latestMessage: latestMessage ?? this.latestMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'status': status,
      'user': user,
      'idClass': idClass.toMap(),
      'createdAt': createdAt.toString(),
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['_id'] ?? '',
      status: map['status']?.toInt() ?? 0,
      user: map['user'] ?? '',
      idClass: ClassModel.fromMap(map['idClass']),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      latestMessage: map['idClass']['latestMessage'] == null
          ? null
          : LatestMessage.fromMap(map['idClass']['latestMessage']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConversationModel(id: $id, status: $status, user: $user, idClass: $idClass, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConversationModel &&
        other.id == id &&
        other.status == status &&
        other.user == user &&
        other.idClass == idClass &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ status.hashCode ^ user.hashCode ^ idClass.hashCode ^ createdAt.hashCode;
  }
}

class LatestMessage {
  final String id;
  final int status;
  final int typeMessage;
  final String idClass;
  final String message;
  final String sender;
  final DateTime createdAt;
  LatestMessage({
    required this.id,
    required this.status,
    required this.typeMessage,
    required this.idClass,
    required this.message,
    required this.sender,
    required this.createdAt,
  });

  LatestMessage copyWith({
    String? id,
    int? status,
    int? typeMessage,
    String? idClass,
    String? message,
    String? sender,
    DateTime? createdAt,
  }) {
    return LatestMessage(
      id: id ?? this.id,
      status: status ?? this.status,
      typeMessage: typeMessage ?? this.typeMessage,
      idClass: idClass ?? this.idClass,
      message: message ?? this.message,
      sender: sender ?? this.sender,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'status': status,
      'typeMessage': typeMessage,
      'idClass': idClass,
      'message': message,
      'sender': sender,
      'createdAt': createdAt.toString(),
    };
  }

  factory LatestMessage.fromMap(Map<String, dynamic> map) {
    return LatestMessage(
      id: map['_id'] ?? '',
      status: map['status']?.toInt() ?? 0,
      typeMessage: map['typeMessage']?.toInt() ?? 0,
      idClass: map['idClass'] ?? '',
      message: map['message'] ?? '',
      sender: map['sender'] ?? '',
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  factory LatestMessage.fromMessageModel(MessageModel message) {
    return LatestMessage(
      id: message.id,
      status: 1,
      typeMessage: 1,
      idClass: message.idClass,
      message: message.message,
      sender: message.sender.id,
      createdAt: message.createdAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory LatestMessage.fromJson(String source) => LatestMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LatestMessage(id: $id, status: $status, typeMessage: $typeMessage, idClass: $idClass, message: $message, sender: $sender, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatestMessage &&
        other.id == id &&
        other.status == status &&
        other.typeMessage == typeMessage &&
        other.idClass == idClass &&
        other.message == message &&
        other.sender == sender &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        typeMessage.hashCode ^
        idClass.hashCode ^
        message.hashCode ^
        sender.hashCode ^
        createdAt.hashCode;
  }
}
