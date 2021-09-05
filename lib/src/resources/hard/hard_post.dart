import 'dart:convert';

class Post {
  final String id;
  String groupName;
  String authorName;
  String imageGroup;
  String imageAuthor;
  String content;
  Post({
    required this.id,
    required this.groupName,
    required this.authorName,
    required this.imageGroup,
    required this.imageAuthor,
    required this.content,
  });

  Post copyWith({
    String? id,
    String? groupName,
    String? authorName,
    String? imageGroup,
    String? imageAuthor,
    String? content,
  }) {
    return Post(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      authorName: authorName ?? this.authorName,
      imageGroup: imageGroup ?? this.imageGroup,
      imageAuthor: imageAuthor ?? this.imageAuthor,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupName': groupName,
      'authorName': authorName,
      'imageGroup': imageGroup,
      'imageAuthor': imageAuthor,
      'content': content,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      groupName: map['groupName'],
      authorName: map['authorName'],
      imageGroup: map['imageGroup'],
      imageAuthor: map['imageAuthor'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, groupName: $groupName, authorName: $authorName, imageGroup: $imageGroup, imageAuthor: $imageAuthor, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.id == id &&
        other.groupName == groupName &&
        other.authorName == authorName &&
        other.imageGroup == imageGroup &&
        other.imageAuthor == imageAuthor &&
        other.content == content;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        groupName.hashCode ^
        authorName.hashCode ^
        imageGroup.hashCode ^
        imageAuthor.hashCode ^
        content.hashCode;
  }
}
