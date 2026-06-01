// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get logIngredient => 'Logee ingredientee to nutrition diary';

  @override
  String get ingredientLogged => 'Ingredientee loggedee to diary';

  @override
  String get weight => 'Weight';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get recentIngredients =>
      'Recently Used ingredients - french lang (app_fr.arb)';

  @override
  String get noEntries => 'No matching items foundeee (fr)';
}
