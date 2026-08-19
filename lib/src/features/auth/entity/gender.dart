import '../../../config/language/locale_keys.g.dart';

enum Gender {
  male('male'),
  female('female');

  final String value;

  const Gender(this.value);

  static Gender? fromValue(String value) {
    final normalizedValue = value.trim().toLowerCase();
    for (final gender in Gender.values) {
      if (gender.value == normalizedValue ||
          gender.label.toLowerCase() == normalizedValue) {
        return gender;
      }
    }
    return null;
  }

  String get label => switch (this) {
    Gender.male => LocaleKeys.signUpMale,
    Gender.female => LocaleKeys.signUpFemale,
  };
}
