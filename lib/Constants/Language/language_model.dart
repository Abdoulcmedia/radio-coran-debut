class Language {
  int id;
  final String flag;
  final String name;
  final String languageCode;
  final String countryCode;

  Language(this.id, this.flag, this.name, this.languageCode,this.countryCode);

  static List<Language> languageList = <Language>[
    Language(1, "🇺🇸", "English", "en","US"),
    Language(2, "🇮🇳", "हिंदी", "hi","IN"),
    Language(3, "🇸🇦", "اَلْعَرَبِيَّةُ", "ar","SA"),
    Language(4, "🇫🇷", "française", "fr","FR"),
  ];
}
