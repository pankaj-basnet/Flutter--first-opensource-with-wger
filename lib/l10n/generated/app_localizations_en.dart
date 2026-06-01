// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get logIngredient => 'Log ingredient to nutrition diary';

  @override
  String get ingredientLogged => 'Ingredient logged to diary';

  @override
  String get weight => 'Weight';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get recentIngredients => 'Recently Used ingredients';

  @override
  String get noEntries => 'No matching items found';
}
