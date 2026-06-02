import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Title text for the ingredient logging application bar
  ///
  /// In en, this message translates to:
  /// **'Log ingredient to nutrition diary'**
  String get logIngredient;

  /// Toast or snackbar message confirming data persistence
  ///
  /// In en, this message translates to:
  /// **'Ingredient logged to diary'**
  String get ingredientLogged;

  /// Label text inside the ingredient search field
  ///
  /// In en, this message translates to:
  /// **'Search ingredient'**
  String get searchIngredient;

  /// Validation message fallback for ingredient selector fields
  ///
  /// In en, this message translates to:
  /// **'Please enter or select an ingredient'**
  String get enterOrSelectIngredient;

  /// Label for mass or weight input fields
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// The metric unit symbol for grams
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get g;

  /// Validation error text when a field is left empty
  ///
  /// In en, this message translates to:
  /// **'Please enter a value'**
  String get enterValue;

  /// Validation error text when input is non-numeric
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get enterValidNumber;

  /// Validation error text enforcing numeric boundaries
  ///
  /// In en, this message translates to:
  /// **'Value must be between {min} and {max}'**
  String formMinMaxValues(num min, num max);

  /// Label for calendar selection inputs
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Label for system clock selection inputs
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Header title text for the macronutrient summary breakdown block
  ///
  /// In en, this message translates to:
  /// **'Macros preview'**
  String get macrosPreview;

  /// Generic description fallback key
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Text for form submission and persistence actions
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Section header displaying historical data lists
  ///
  /// In en, this message translates to:
  /// **'Recently Used Ingredients'**
  String get recentlyUsedIngredients;

  /// Fallback string displayed when filter search returns zero records
  ///
  /// In en, this message translates to:
  /// **'No matching items found'**
  String get noEntries;

  /// Label text on dialogue cancellation steps
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
