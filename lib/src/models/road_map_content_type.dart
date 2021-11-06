import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum RoadMapContentType {
  assignment,
  attendance,
}

extension RoadMapContentTypeExtension on RoadMapContentType {
  String get value {
    switch (this) {
      case RoadMapContentType.assignment:
        return 'Bài tập';
      case RoadMapContentType.attendance:
        return 'Điểm danh';
    }
  }

  IconData get icon {
    switch (this) {
      case RoadMapContentType.assignment:
        return PhosphorIcons.folderOpenFill;
      case RoadMapContentType.attendance:
        return PhosphorIcons.handsClappingFill;
    }
  }

  List<RoadMapContentType> get getListRoadMap {
    return [
      RoadMapContentType.assignment,
      RoadMapContentType.attendance,
    ];
  }
}
