enum QuestionType {
  multipleChoise,
  singleChoise,
  trueFalse,
  // audio,
  dragAndDrop,
}

extension ConvertTypeToEnum on QuestionType {
  String getTileByEnum() {
    switch (this) {
      case QuestionType.multipleChoise:
        return 'Nhiều lựa chọn';
      case QuestionType.singleChoise:
        return 'Một lựa chọn';
      case QuestionType.trueFalse:
        return 'Đúng/Sai';
      // case QuestionType.audio:
      //   return 'Âm thanh';
      case QuestionType.dragAndDrop:
        return 'Kéo thả đáp án';
      default:
        return 'Một lựa chọn';
    }
  }

  int getTypeNumber() {
    switch (this) {
      case QuestionType.multipleChoise:
        return 1;
      case QuestionType.singleChoise:
        return 2;
      case QuestionType.trueFalse:
        return 3;
      // case QuestionType.audio:
      //   return 5;
      case QuestionType.dragAndDrop:
        return 7;
      default:
        return 2;
    }
  }
}

QuestionType fromTypeNumber({required int type}) {
    switch (type) {
      case 1:
        return QuestionType.multipleChoise;
      case 2:
        return QuestionType.singleChoise;
      case 3:
        return QuestionType.trueFalse;
      // case 5:
      //   return QuestionType.audio;
      case 7:
        return QuestionType.dragAndDrop;
      default:
        return QuestionType.singleChoise;
    }
  }
