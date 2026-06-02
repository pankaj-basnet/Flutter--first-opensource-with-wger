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
  String get searchIngredient => 'Search ingredient';

  @override
  String get enterOrSelectIngredient => 'Please enter or select an ingredient';

  @override
  String get weight => 'Weight';

  @override
  String get g => 'g';

  @override
  String get enterValue => 'Please enter a value';

  @override
  String get enterValidNumber => 'Please enter a valid number';

  @override
  String formMinMaxValues(num min, num max) {
    return 'Value must be between $min and $max';
  }

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get macrosPreview => 'Macros preview';

  @override
  String get description => 'Description';

  @override
  String get save => 'Save';

  @override
  String get recentlyUsedIngredients => 'Recently Used Ingredients';

  @override
  String get noEntries => 'No matching items found';

  @override
  String get close => 'Close';
}
