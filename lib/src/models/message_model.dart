import 'dart:convert';

import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/user.dart';

class MessageModel {
  final String id;
  final int status;
  final int typeMessage;
  final String idClass;
  final String message;
  final UserModel sender;
  final DateTime createdAt;
  MessageModel({
    required this.id,
    required this.status,
    required this.typeMessage,
    required this.idClass,
    required this.message,
    required this.sender,
    required this.createdAt,
  });

  MessageModel copyWith({
    String? id,
    int? status,
    int? typeMessage,
    String? idClass,
    String? message,
    UserModel? sender,
    DateTime? createdAt,
  }) {
    return MessageModel(
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

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] ?? '',
      status: map['status']?.toInt() ?? 0,
      typeMessage: map['typeMessage']?.toInt() ?? 0,
      idClass: map['idClass'] ?? '',
      message: map['message'] ?? '',
      sender: UserModel.fromMap(map['sender']),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  factory MessageModel.fromMapCreate(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] ?? '',
      status: map['status']?.toInt() ?? 0,
      typeMessage: map['typeMessage']?.toInt() ?? 0,
      idClass: map['idClass'] ?? '',
      message: map['message'] ?? '',
      sender: AppBloc.authBloc.userModel!,
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, status: $status, typeMessage: $typeMessage, idClass: $idClass, message: $message, sender: $sender, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
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

  bool get isMe => AppBloc.authBloc.userModel!.id == sender.id;
}
