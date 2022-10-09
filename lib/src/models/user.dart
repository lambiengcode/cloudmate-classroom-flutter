import 'dart:convert';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/public/constants.dart';

class UserModel {
  final String id;
  final String? image;
  final String? blurHash;
  String? phone;
  String? displayName;
  String? firstName;
  String? lastName;
  final int? status;
  String? intro;
  final int? role;
  final int? score;

  UserModel({
    required this.id,
    this.image,
    this.blurHash,
    this.phone,
    this.displayName,
    this.firstName,
    this.lastName,
    this.status,
    this.intro,
    this.role,
    this.score,
  });

  UserModel copyWith({
    String? id,
    String? image,
    String? blurHash,
    String? phone,
    String? displayName,
    String? firstName,
    String? lastName,
    int? status,
    String? intro,
    int? role,
    int? score,
  }) {
    return UserModel(
      id: id ?? this.id,
      image: image ?? this.image,
      blurHash: blurHash ?? this.blurHash,
      phone: phone ?? this.phone,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
      intro: intro ?? this.intro,
      role: role ?? this.role,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'image': image,
      'blurHash': blurHash,
      'phone': phone,
      'displayName': displayName,
      'firstName': firstName,
      'lastName': lastName,
      'status': status,
      'intro': intro,
      'role': role,
      'score': score,
    };
  }

  factory UserModel.fromMap(dynamic map, {int? role}) {
    // late final Map<String, String> defaultImageObject;
    // defaultImageObject = Constants.getOnlyDefaultClassImage();

    return UserModel(
      id: map['_id'] ?? '',
      image: map['image'] == Constants.urlImageDefault ||
              map['image'] == null ||
              map['image'] == ''
          ? Constants.urlImageDefault
          : map['image'].toString().contains('http')
              ? map['image']
              : (Application.imageUrl + map['image']),
      blurHash: map['blurHash'] ?? '',
      phone: map['phone'] ?? '',
      displayName: map['displayName'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      status: map['status'] ?? 0,
      intro: map['intro'],
      role: role ?? 0,
    );
  }

  factory UserModel.fromStatistic(Map<dynamic, dynamic> map, {int? score}) {
    // late final Map<String, String> defaultImageObject;
    // defaultImageObject = Constants.getOnlyDefaultClassImage();
    return UserModel(
      id: map['_id'],
      image: map['image'] == null || map['image'] == ''
          ? Constants.urlImageDefault
          : (Application.imageUrl + map['image']),
      blurHash: map['blurHash'] ?? '',
      phone: map['phone'] ?? '',
      displayName: map['displayName'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      status: map['status'] ?? 0,
      intro: map['intro'],
      role: 0,
      score: score ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, image: $image, blurHash: $blurHash, phone: $phone, displayName: $displayName, firstName: $firstName, lastName: $lastName, status: $status, intro: $intro)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.image == image &&
        other.blurHash == blurHash &&
        other.phone == phone &&
        other.displayName == displayName &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.status == status &&
        other.intro == intro;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        blurHash.hashCode ^
        phone.hashCode ^
        displayName.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        status.hashCode ^
        intro.hashCode;
  }
}
