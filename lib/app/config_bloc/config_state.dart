part of 'config_bloc.dart';

class ConfigState extends Equatable {
  final String langCode;
  final bool darkTheme;

  const ConfigState({required this.langCode, required this.darkTheme});

  const ConfigState.initial({langCode = LANG_EN, darkTheme = true})
      : this(langCode: langCode, darkTheme: darkTheme);

  ConfigState copyWith({String? langCode, bool? darkTheme}) {
    return ConfigState(
        langCode: langCode ?? this.langCode,
        darkTheme: darkTheme ?? this.darkTheme);
  }

  Map<String, bool> get languages => {
        'English': langCode == LANG_EN,
        'Russian': langCode == LANG_RU,
      };

  String getLangCode(String lang) {
    switch (lang) {
      case 'English':
        return LANG_EN;
      case 'Russian':
        return LANG_RU;
    }
    return LANG_EN;
  }

  @override
  List<Object?> get props => [langCode, darkTheme];
}
