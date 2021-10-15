import 'dart:convert';

class UploadResponseModel {
  final String image;
  final String blurHash;
  UploadResponseModel({
    required this.image,
    required this.blurHash,
  });

  UploadResponseModel copyWith({
    String? image,
    String? blurHash,
  }) {
    return UploadResponseModel(
      image: image ?? this.image,
      blurHash: blurHash ?? this.blurHash,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'blurHash': blurHash,
    };
  }

  factory UploadResponseModel.fromMap(Map<String, dynamic> map) {
    return UploadResponseModel(
      image: map['image'],
      blurHash: map['blurHash'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadResponseModel.fromJson(String source) =>
      UploadResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UploadResponseModel(image: $image, blurHash: $blurHash)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UploadResponseModel &&
        other.image == image &&
        other.blurHash == blurHash;
  }

  @override
  int get hashCode => image.hashCode ^ blurHash.hashCode;
}
