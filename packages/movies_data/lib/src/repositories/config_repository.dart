import 'package:movies_data/src/api/language_preferences.dart';
import 'package:movies_data/src/api/theme_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigRepository {
  final SharedPreferences preferences;
  final ThemePreference themePreference;
  final LanguagePreferences languagePreferences;

  ConfigRepository(this.preferences)
      : themePreference = ThemePreference(preferences),
        languagePreferences = LanguagePreferences(preferences) {
    init();
  }

  init() async {
    _darkTheme = await themePreference.getTheme();
    _appLocale = await languagePreferences.getLanguage();
  }

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  String _appLocale = LANG_EN;

  String get appLocale => _appLocale;

  set appLang(String langCode) {
    _appLocale = langCode;
    languagePreferences.setLanguage(langCode);
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    themePreference.setDarkTheme(value);
  }
}
