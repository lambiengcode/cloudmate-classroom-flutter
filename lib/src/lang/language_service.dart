import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i18n_extension/i18n_widget.dart';

class LanguageService {
  final _getStorage = GetStorage();
  final storageKey = 'locale';

  String getLocale() {
    return _getStorage.read(storageKey) ?? 'vi_vn';
  }

  Future<void> saveLocale(String locale) async {
    print('s2');
    await _getStorage.write(storageKey, locale);
  }

  switchLanguage(context) async {
    print('s1');
    await saveLocale((I18n.localeStr == "vi_vn") ? "en_us" : "vi_vn");
    I18n.of(context).locale =
        (I18n.localeStr == "vi_vn") ? null : const Locale("vi", "VN");
  }

  initialLanguage(context) {
    String localeStr = getLocale();
    print(localeStr);
    if (localeStr == "vi_vn") {
      I18n.of(context).locale = Locale("vi", "VN");
    } else {
      I18n.of(context).locale = null;
    }
  }
}
