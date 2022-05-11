import 'package:i18n_extension/i18n_extension.dart';

const classTitle = 'class';
const yourClass = 'yourClass';
const recommendClass = 'recommendClass';

extension Localization on String {
  static final _t = Translations.from("en_us", {
    classTitle: {
      "en_us": "Lớp học",
      "vi_vn": "Lớp học",
    },
    yourClass: {
      "en_us": "Lớp học của bạn",
      "vi_vn": "Lớp học của bạn",
    },
    recommendClass: {
      "en_us": "Lớp học đề xuất",
      "vi_vn": "Lớp học đề xuất",
    }
  });

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);
}
