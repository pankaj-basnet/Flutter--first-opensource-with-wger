import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/forms.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<NutritionalPlan> getDataFromGithub() async {
    const url =
        'https://raw.githubusercontent.com/pankaj-basnet/Flutter--first-opensource-with-wger/main/mockdata/nutritional_plan_data.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // return data as NutritionalPlan;
        return Map<String, dynamic>.from(data as Map);
      } else {
        throw Exception(
          'Failed to load nutritional plan. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network or parsing error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealFlutter',
      theme: rfLightTheme,
      home: FutureBuilder<NutritionalPlan>(
        future: getDataFromGithub(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else if (snapshot.hasData) {
            return getIngredientLogForm(snapshot.data!);
          } else {
            return const Scaffold(body: Center(child: Text('No data found.')));
          }
        },
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
