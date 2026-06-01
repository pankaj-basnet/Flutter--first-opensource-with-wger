
import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xff2f568d); // Shifted from wger's 0xff2a4c7d
const Color kPrimaryButtonColor = Color(0xff3377e3); // Shifted from wger's 0xff266dd3
const Color kPrimaryColorLight = Color(0xffa3c0e8); // Shifted from wger's 0xff94B2DB

const Color kSecondaryColor = Color(0xffeb4e5a); // Shifted from wger's 0xffe63946
const Color kSecondaryColorLight = Color(0xffffc2c8); // Shifted from wger's 0xffF6B4BA
const Color kTertiaryColor = Color(0xFF76b359); // Shifted from wger's 0xFF6CA450


const String kDisplayFont = 'GoogleSans';
const List<FontVariation> displayFontBoldWeight = [FontVariation('wght', 600)];
const List<FontVariation> displayFontHeavyWeight = [FontVariation('wght', 800)];

// Make a light ColorScheme from the seeds.
final ColorScheme kschemeLight = ColorScheme.fromSeed(
  seedColor: kPrimaryColor ,
  primary: kPrimaryColor,
  // primaryKey: wgerPrimaryColor,
  // secondaryKey: wgerSecondaryColor,
  secondary: kSecondaryColor,
  // tertiaryKey: wgerTertiaryColor,
  tertiary: kTertiaryColor,
  // brightness: Brightness.light,
  // tones: FlexTones.vivid(Brightness.light),
);


const kTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontHeavyWeight,
  ),
  displayMedium: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontHeavyWeight,
  ),
  displaySmall: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontHeavyWeight,
  ),
  headlineLarge: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  headlineMedium: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  headlineSmall: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  titleLarge: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  titleMedium: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  titleSmall: TextStyle(
    fontFamily: kDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
);

final rfLightTheme = ThemeData(
  colorScheme: kschemeLight,
  useMaterial3: true,
  // appBarStyle: FlexAppBarStyle.primary,
  // subThemesData: wgerSubThemeData,
  textTheme: kTextTheme,
);