// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get logIngredient => 'Enregistrer un ingrédient dans le journal';

  @override
  String get ingredientLogged => 'Ingrédient enregistré dans le journal';

  @override
  String get searchIngredient => 'Rechercher un ingrédient';

  @override
  String get enterOrSelectIngredient =>
      'Veuillez saisir ou sélectionner un ingrédient';

  @override
  String get weight => 'Poids';

  @override
  String get g => 'g';

  @override
  String get enterValue => 'Veuillez saisir une valeur';

  @override
  String get enterValidNumber => 'Veuillez saisir un nombre valide';

  @override
  String formMinMaxValues(num min, num max) {
    return 'La valeur doit être comprise entre $min et $max';
  }

  @override
  String get date => 'Date';

  @override
  String get time => 'Heure';

  @override
  String get macrosPreview => 'Aperçu des macros';

  @override
  String get description => 'Description';

  @override
  String get save => 'Enregistrer';

  @override
  String get recentlyUsedIngredients => 'Ingrédients récemment utilisés';

  @override
  String get noEntries => 'Aucun élément correspondant trouvé';

  @override
  String get close => 'Fermer';
}
