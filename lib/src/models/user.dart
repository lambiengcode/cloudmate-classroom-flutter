import 'dart:convert';

class UserModel {
  final String id;
  final String image;
  final String email;
  final String phone;
  final String fullName;
  UserModel({
    required this.id,
    required this.image,
    required this.email,
    required this.phone,
    required this.fullName,
  });

  UserModel copyWith({
    String? id,
    String? image,
    String? email,
    String? phone,
    String? fullName,
  }) {
    return UserModel(
      id: id ?? this.id,
      image: image ?? this.image,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'email': email,
      'phone': phone,
      'fullName': fullName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      image: map['image'],
      email: map['email'],
      phone: map['phone'],
      fullName: map['fullName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, image: $image, email: $email, phone: $phone, fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.image == image &&
        other.email == email &&
        other.phone == phone &&
        other.fullName == fullName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        fullName.hashCode;
  }
}
