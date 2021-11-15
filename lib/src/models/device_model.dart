import 'dart:convert';

class DeviceModel {
  final String appVersion;
  final String deviceModel;
  final String deviceUUid;
  final String fcmToken;
  DeviceModel({
    required this.appVersion,
    required this.deviceModel,
    required this.deviceUUid,
    required this.fcmToken,
  });

  DeviceModel copyWith({
    String? appVersion,
    String? deviceModel,
    String? deviceUUid,
    String? fcmToken,
  }) {
    return DeviceModel(
      appVersion: appVersion ?? this.appVersion,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceUUid: deviceUUid ?? this.deviceUUid,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appVersion': appVersion,
      'deviceModel': deviceModel,
      'deviceUUid': deviceUUid,
      'fcmToken': fcmToken,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      appVersion: map['appVersion'],
      deviceModel: map['deviceModel'],
      deviceUUid: map['deviceUUid'],
      fcmToken: map['fcmToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) => DeviceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DeviceModel(appVersion: $appVersion, deviceModel: $deviceModel, deviceUUid: $deviceUUid, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DeviceModel &&
      other.appVersion == appVersion &&
      other.deviceModel == deviceModel &&
      other.deviceUUid == deviceUUid &&
      other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    return appVersion.hashCode ^
      deviceModel.hashCode ^
      deviceUUid.hashCode ^
      fcmToken.hashCode;
  }
}
